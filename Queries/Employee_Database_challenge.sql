-- Deliverable 1 - getting retirement titles into a csv

select e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
into retirement_titles
from employees as e
join titles as t
on e.emp_no = t.emp_no
where ( e.birth_date >= '1952-01-01') and (e.birth_date <= '1955-12-31')
order by e.emp_no

-- Deliverable 1 - get unique titles and only employees still employed

select distinct on (r.emp_no) r.emp_no, r.first_name, r.last_name, r.title
into unique_titles
from retirement_titles as r
where ( r.to_date = '9999-01-01')
order by r.emp_no asc, r.to_date desc

-- Deliverable 1 Count the number of potential retirees by title
select count(ut.title), ut.title
into retiring_titles
from unique_titles as ut
group by ut.title
order by count(ut.title) desc

-- Deliverable 2 Mentorship Eligibility list

select distinct on (t.emp_no) t.emp_no,  e.first_name,
	e.last_name, e.birth_date, 
	de.from_date, de.to_date, t.title
into mentorship_eligibility
from employees as e
join dept_emp as de
on e.emp_no = de.emp_no
join titles as t
on e.emp_no = t.emp_no
where (de.to_date = '9999-01-01') and
	  (e.birth_date >= '1965-01-01')and
	  (e.birth_date <= '1965-12-31')
order by t.emp_no 

