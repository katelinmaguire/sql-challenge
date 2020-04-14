
-- Import data from each .csv files to the corresponding tables
COPY employees FROM '/Applications/PostgreSQL 12/sql-challenge/employees.csv' DELIMITER ',' CSV HEADER;
COPY departments FROM '/Applications/PostgreSQL 12/sql-challenge/departments.csv' DELIMITER ',' CSV HEADER;
COPY dept_emp FROM '/Applications/PostgreSQL 12/sql-challenge/dept_emp.csv' DELIMITER ',' CSV HEADER;
COPY dept_manager FROM '/Applications/PostgreSQL 12/sql-challenge/dept_manager.csv' DELIMITER ',' CSV HEADER;
COPY salaries FROM '/Applications/PostgreSQL 12/sql-challenge/salaries.csv' DELIMITER ',' CSV HEADER;
COPY titles FROM '/Applications/PostgreSQL 12/sql-challenge/titles.csv' DELIMITER ',' CSV HEADER;

-- Check imported data
SELECT * FROM employees LIMIT 50;
SELECT * FROM departments LIMIT 50;
SELECT * FROM dept_emp LIMIT 50;
SELECT * FROM dept_manager LIMIT 50;
SELECT * FROM salaries LIMIT 50;
SELECT * FROM titles LIMIT 50;

-- List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT 
employees.emp_no, 
employees.last_name, employees.first_name,
employees.gender, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY emp_no;

-- List employees who were hired in 1986.

SELECT *
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date desc;

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT 
dept_manager.dept_no, departments.dept_name,
dept_manager.emp_no, employees.last_name, employees.first_name,
dept_emp.from_date, dept_emp.to_date
FROM dept_manager
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN dept_emp ON dept_manager.emp_no = dept_emp.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
ORDER BY dept_no;

-- List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT 
employees.emp_no,
employees.last_name, employees.first_name,
departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
ORDER BY dept_name;

-- List all employees whose first name is "Hercules" and last names begin with "B."

SELECT 
first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name like 'B%'
ORDER BY last_name;

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT 
employees.emp_no,
employees.last_name, employees.first_name,
departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
ORDER BY emp_no;

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
employees.emp_no,
employees.last_name, employees.first_name,
departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE (departments.dept_name = 'Sales' or departments.dept_name = 'Development')
ORDER BY dept_name;

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT 
last_name, count(last_name) AS "name frequency"
FROM employees
GROUP BY last_name
ORDER BY "name frequency" desc;