{#
sensu_check:
generic check executor
#}

{% macro sensu_check(name,
                     command,
                     type='standard',
                     handlers=['default'],
                     interval=60,
                     subscribers=['all'],
                     occurrences=1,
                     playbook=False,
                     source=False
                     ) %}

/etc/sensu/conf.d/{{name}}.json:
  file.managed:
    - source: salt://tools/sensuserver/files/checks.json
    - template: jinja
    - mode: 600
    - owner: sensu
    - group: sensu
    - context:
        name: {{name}}
        command: "{{command}}"
        type: {{type}}
        handlers: {{handlers}}
        interval: {{interval}}
        subscribers: {{subscribers}}
        occurrences: {{occurrences}}
        playbook: {{playbook}}
        source: {{source}}
    - require:
      - file: /etc/sensu/conf.d/api.json
    - watch_in:
      - service: sensu-server
      - service: sensu-api

{% endmacro %}
