{% for package in pillar['my_packages'] %}
{{ package }}:
  pkg.installed
{% endfor %}
