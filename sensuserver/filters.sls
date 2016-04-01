/etc/sensu/conf.d/filters.json:
  file.managed:
    - source: salt://tools/sensuserver/files/filters.json
    - template: jinja
    - mode: 600
    - owner: sensu
    - group: sensu
    - require:
      - file: /etc/sensu/conf.d/api.json
    - watch_in:
      - service: sensu-server
      - service: sensu-api
