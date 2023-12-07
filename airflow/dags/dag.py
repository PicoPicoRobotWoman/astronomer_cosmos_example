import os

from datetime import datetime

from airflow.decorators import dag
from airflow.operators.python import PythonOperator

from cosmos import DbtDag, ProjectConfig, ProfileConfig, DbtTaskGroup
from clickhouse_driver import Client


client = Client(
    host='clickhouse',
    port=9000,
    user='default',
    password='12345',
    database='default'
)


dbt_path = "/usr/local/airflow/dbt/dbt_pet"
profile_config = ProfileConfig( 
    profile_name="dbt_pet", 
    target_name="dev", 
    profiles_yml_filepath=dbt_path + "/profiles.yml"
) 


def execute_sql_from_file(file_path):
    with open(file_path, 'r') as file:
        query = file.read()
        client.execute(query)  


def drop_tables():

    tables = ['login', 'funnel', 'finance']

    for table in tables:
        query = f"DROP TABLE IF EXISTS {table}"
        client.execute(query)        


def create_tables():

    path_to_sql_scripts = os.environ.get('AIRFLOW_HOME') + '/sql-scripts/'
    
    sql_scripts = ['login_create.sql', 'login_isert.sql', 'funnel_create.sql', 'funnel_insert.sql', 'finance_create.sql', 'finance_insert.sql']

    for script in sql_scripts:
        execute_sql_from_file(path_to_sql_scripts + script)


def close_client():
    client.disconnect()

@dag(
    schedule_interval="@daily",
    start_date=datetime.utcnow(),
    catchup=False,
    tags=["dbt"],
)
def dbt_run() -> None:
  

    drop_tables_op = PythonOperator(
    task_id='drop_tables',
    python_callable=drop_tables,
    )


    create_tables_op = PythonOperator(
    task_id='create_tables',
    python_callable=create_tables,
    )

    dbt_per_op = DbtTaskGroup(
        project_config=ProjectConfig(
            dbt_path,
        ),
        profile_config=profile_config,
        operator_args={
            "install_deps": False,
        },
        default_args={"retries": 2},
    )    

    close_client_op = PythonOperator(
    task_id='close_client',
    python_callable=close_client,
    )


    drop_tables_op >> create_tables_op >> dbt_per_op >> close_client_op

dbt_run()

