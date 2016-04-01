/etc/sensu/conf.d/handlers.json:
  file.managed:
    - source: salt://tools/sensuserver/files/handlers.json
    - template: jinja
    - mode: 600
    - owner: sensu
    - group: sensu
    - context:
        opsgenie_apikey: {{ salt['pillar.get']('stupidsoup:sensu:config:handlers:opsgenie:api_key') }}
        slack_webhook: {{ salt['pillar.get']('stupidsoup:sensu:config:handlers:slack:webhook') }}
    - require:
      - file: /etc/sensu/conf.d/api.json
    - watch_in:
      - service: sensu-server
      - service: sensu-api
