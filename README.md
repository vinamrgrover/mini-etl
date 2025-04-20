# Mini ETL

A project focused on creating a mini ETL Pipeline to get started with Data Engineering.

## Architecture Diagram
![mini_etl](https://github.com/user-attachments/assets/9ce0c249-ba1d-47b2-b5e7-d285bcca6877)


## Description

This project is based on writing bash scripts to demonstrate an ETL process.
Here's the workflow - Fetching data from github api, transforming it, loading it into a PostgreSQL table.

## Prerequisites

- PostgreSQL
- working with APIs
- bash

## Getting started

#### 1. Clone the repo

```shell
git clone https://github.com/vinamrgrover/mini-etl.git
```

### 2. Configure environment variables

In the .env file, configure your PostgreSQL environment variables - host, port, user, password, database

```shell
vim .env
```

### 3. Run the script

Finally, run the `exec.sh` script to initiate a mini ETL process. The results will be saved in your table `repo_stats`

```shell
chmod +x ./exec.sh
./exec.sh <search_query>
```

Make sure to replace the `<search_query>` with your own.

That's all! This was a simple project to help you get started with ETL!
