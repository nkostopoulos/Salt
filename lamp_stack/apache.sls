# Install apache package
install apache package:
  pkg.installed:
    - pkgs:
      - apache2
    - refresh: True

# Restart apache service
apache2:
  service.running:
    - enable: True
    - reload: True
