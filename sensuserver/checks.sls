{% from "tools/sensuserver/lib.sls" import sensu_check with context %}

{% set check_definitions = salt['pillar.get']('stupidsoup:sensu:config:checks', {}) %}
{% for name, check in check_definitions.items() %}
{{ sensu_check(
               name,
               check['command'],
               type=check['type']|default('standard'),
               handlers=check['handlers']|default(['default']),
               interval=check['interval']|default(60),
               subscribers=check['subscribers']|default(['all']),
               occurrences=check['occurrences']|default(1),
               playbook=check['playbook']|default(False)
              )
}}
{% endfor %}
