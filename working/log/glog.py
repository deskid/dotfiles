#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import subprocess

from jinja2 import Template

DEBUG = True

release_tag = subprocess.check_output(
    'git tag | grep "-" | sort -s -t- -k 2,2nr |  sort -t. -s -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr',
    shell=True)

tags = release_tag.splitlines()

release_logs = []
for i in range(0, len(tags) - 1):
    tag_time_commond = 'git log -1 --pretty=format:"%ad" --date=short --no-merges ' + \
        '"' + tags[i + 1] + '"'
    tag_time = subprocess.check_output(
        tag_time_commond, shell=True).splitlines()[0]
    release_log = {'tag_name': tags[i][:tags[i].index('-')],
                   'tag_link': tags[i],
                   'tag_time': tag_time,
                   'feature': [],
                   'fix': [],
                   'refactor': [],
                   'deprecated': [],
                   'update': [],
                   'other': [],
                   'test': [],
                   'docs': []
                   }

    show_log_commond = 'git log --pretty=format:"%s" --no-merges ' + \
        '"' + tags[i + 1] + '".."' + tags[i] + '"'

    log_result = subprocess.check_output(show_log_commond, shell=True)
    logs = log_result.splitlines()

    for log in logs:
        log = log.decode('utf-8')
        if log.startswith('fix') or log.startswith('fixup'):
            release_log['fix'].append(log)
            continue
        elif log.startswith('feat') or log.startswith('feature') or log.startswith('add'):
            release_log['feature'].append(log)
            continue
        elif log.startswith('refact') or log.startswith('refactor'):
            release_log['refactor'].append(log)
            continue
        elif log.startswith('test'):
            release_log['test'].append(log)
            continue
        elif log.startswith('docs'):
            release_log['docs'].append(log)
            continue
        elif log.startswith('delete') or log.startswith('deprecated'):
            release_log['deprecated'].append(log)
            continue
        elif log.startswith('update:'):
            release_log['update'].append(log)
            continue
        else:
            if log.startswith('[AUTO COMMIT]'):
                continue
            release_log['other'].append(log)

    release_logs.append(release_log)

template_path = 'changelog.md'
ROOT_PATH = os.path.abspath(os.path.join(os.path.abspath(__file__), os.pardir))
with open(os.path.join(ROOT_PATH, template_path), 'r') as log_template:
    content = log_template.read().decode('utf-8')
    template = Template(content)
    result = template.render(release_logs=release_logs)
    with open('changlog.md', 'w') as log_file:
        log_file.write(result.encode('utf-8'))
        log_file.flush()
print 'README.md added'
