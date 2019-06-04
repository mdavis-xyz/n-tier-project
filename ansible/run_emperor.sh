#!/bin/bash
{{ venv_path }}/bin/uwsgi --master --emperor {{ vassal_dir }} --die-on-term --uid {{ nginx_user }} --gid {{ nginx_group }} --logto {{ uwsgi_log_dir }}/emperor.log

