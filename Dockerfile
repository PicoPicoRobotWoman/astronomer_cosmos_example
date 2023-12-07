FROM python:3.7

USER root

ARG AIRFLOW_VERSION=2.1.4

ENV AIRFLOW_HOME=/usr/local/airflow

RUN pip install dbt-clickhouse

RUN pip install apache-airflow[postgres]==${AIRFLOW_VERSION}

RUN pip install SQLAlchemy==1.3.23

RUN pip install astronomer-cosmos

RUN pip install clickhouse-driver

RUN mkdir /project

COPY scripts/ /project/scripts/

COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

RUN chmod +x /project/scripts/init.sh

ENTRYPOINT ["/project/scripts/init.sh"]
