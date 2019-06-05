# Troubleshooting

Main directory is {{ app_dir }}

## Log locations

* `/var/log/nginx/*.log`
* `{{ uwsgi_log_dir }}/*.log`
 
## Mysql

* user: {{ sql_user }}
* database:  {{ database_name }}
* host: {{ sql_host }}

## other info

Services to restart:

* nginx
  * not normally needed
* {{ uwsgi_service_name }}
  * whenever python code changes
* vassal dir: {{ vassal_dir }}
* virtual env location: {{ venv_path }}
