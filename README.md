# **Data Warehouse Transformation and Analysis: OLTP to OLAP with Machine Learning**

## **Project Overview**

This project demonstrates the process of transforming the Chinook database from an OLTP system to an OLAP data warehouse. It includes the creation of an OLAP schema, data transformation, and the development of a Power BI dashboard for data visualization. Additionally, Python is used to perform exploratory data analysis (EDA) and machine learning for business insights, focusing on employee performance.

## **Project Flow**

### 1. **Database Setup**

#### **Staging Database Creation**
- The first step is to create a staging database that mimics the original OLTP schema.
- SQL file: `Sql/ChinookStaging.sql`
  - This script creates a staging database to hold the raw OLTP data for transformation.

#### **OLAP Data Warehouse Creation**
- The staging data is then transformed and loaded into an OLAP schema for efficient querying and reporting.
- SQL file: `Sql/ChinookDW.sql`
  - This script creates the data warehouse schema with a star schema design.

#### **Data Insertion**
- Transformed data is inserted into the OLAP warehouse.
- SQL file: `Sql/inserting.sql`
  - This script loads the transformed data into the newly created data warehouse tables.

#### **Database Backups**
- One `.bak` file is included for restoring OLAP databases.
  - `Sql/ChinookDw.bak`: Backup of the OLAP database.

### 2. **Power BI Dashboard**

- A Power BI dashboard is created to visualize the data from the OLAP warehouse.
  - The dashboard includes key metrics like sales performance, customer trends, and employee data.
  - The `Chinook Dashboard.pbix` file will be available for import into Power BI.

### 3. **Data Analysis with Python**

#### **SQL View Creation**
- A SQL file is provided to create a **view** that joins important tables such as `invoice`, `employee`, and `customer` for further analysis.
- SQL file: `Python/python_view.sql`
  - This script creates a view that consolidates necessary data from multiple tables for use in the analysis.

#### **Data Join and CSV Export**
- After running the SQL view, a CSV file is generated, containing the joined data.
- CSV file: `Python/python_view.csv`
  - This file contains the consolidated data, ready for analysis in Python.

#### **Data Analysis**
- The `Employee_performance.ipynb` Jupyter notebook is used for performing exploratory data analysis (EDA) and machine learning techniques on the joined dataset.
  - The analysis focuses on understanding trends, distributions, and correlations in employee performance and related factors.


## **Usage Instructions**

1. **Download the OLTP Chinook Database**
   - Download the Chinook OLTP database from the official repository:
     - [Chinook Database - OLTP](https://github.com/lerocha/chinook-database)
   - After downloading, restore the database on your SQL Server.

2. **Run SQL Scripts**
   - After setting up the OLTP database, execute the SQL scripts in the following order:
     - `ChinookStaging.sql`: Creates the staging database.
     - `ChinookDW.sql`: Creates the OLAP warehouse schema.
     - `inserting.sql`: Inserts transformed data into the warehouse.
     - `python_view.sql`: Creates a SQL view for the analysis (you will also need to export the view as csv or download it from the python folder).
      

3. **Power BI Dashboard**
   - Open the `dashboard.pbix` file in Power BI.
   - The dashboard will automatically connect to your OLAP database and display key visualizations.
   - You can customize or refresh the data as needed.

4. **Python Analysis**
     - **Run the Analysis**:
     - Load the `python_view.csv` file into the Jupyter notebook.
     - Run the `Employee_performance.ipynb` notebook to perform exploratory data analysis (EDA) and machine learning.

   - **Train Machine Learning Model**:
     - The notebook also contains code to build and evaluate the classification model for employee performance.

## **Technologies Used**
- **SQL Server**: For database management and SQL queries.
- **Power BI**: For creating dashboards and data visualizations.
- **Python**: For data analysis and machine learning (using libraries such as pandas, seaborn, matplotlib, and scikit-learn).

### **Credits**
This project uses the [Chinook Database - OLTP](https://github.com/lerocha/chinook-database) from the official Chinook GitHub repository. Special thanks to the repository authors for making the dataset available.

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
