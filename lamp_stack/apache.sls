# Install nginx package
install nginx package:
  pkg.installed:
    - pkgs:
      - apache2
    - refresh: True

# Restart nginx service
apache2:
  service.running:
    - enable: True
    - reload: True
