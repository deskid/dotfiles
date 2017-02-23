# CHANGELOG
----------------------

{% for log in release_logs %}
## {{ log['tag_time'] }} [ {{log['tag_name']}} ]
{% if log['feature']|length>0 %}
### [feature]
{% for feature_log in log['feature'] -%}
- {{ feature_log }}
{% endfor -%}
{% endif -%}
{% if log['fix']|length>0 %}
### [fix]
{% for fix_log in log['fix'] -%}
- {{ fix_log }}
{% endfor -%}
{% endif -%}
{% if log['refactor']|length>0 %}
### [refactor]
{% for refactor_log in log['refactor'] -%}
- {{ refactor_log }}
{% endfor -%}
{% endif -%}
{% if log['deprecated']|length>0 %}
### [deprecated]
{% for deprecated_log in log['deprecated'] -%}
- {{ deprecated_log }}
{% endfor -%}
{% endif -%}
{% if (log['update']|length) >0 %}
### [update]
{% for update_log in log['update'] -%}
- {{ update_log }}
{% endfor -%}
{% endif -%}
{% if log['other']|length >0 %}
### [other]
{% for other_log in log['other'] -%}
- {{ other_log }}
{% endfor -%}
{% endif -%}
{% endfor -%}
