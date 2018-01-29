{% from 'strongswan/map.jinja' import strongswan with context %}

include:
  - strongswan

# Configure StrongSwan
/etc/ipsec.conf:
  file.managed:
    - source: salt://strongswan/files/ipsec.conf.jinja
    - template: jinja
    - context:
      config: {{ strongswan.config }}
      connections: {{ strongswan.connections }}
    - watch_in:
      - service: strongswan
    - require:
      - pkg: strongswan

/etc/ipsec.secrets:
  file.managed:
    - source: salt://strongswan/files/ipsec.secrets.jinja
    - template: jinja
    - watch_in:
      - service: strongswan
    - require:
      - pkg: strongswan
    - require_in:
      - file: /etc/ipsec.conf
