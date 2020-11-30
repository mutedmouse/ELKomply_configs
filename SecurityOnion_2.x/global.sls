logstash:
  pipelines:
    manager:
      config:
        - so/0009_input_beats.conf
        - so/0010_input_hhbeats.conf
        - so/9999_output_redis.conf.jinja
        - custom/9999_output_splunk_manager.conf.jinja
    search:
      config:
        - so/0900_input_redis.conf.jinja
        - so/9000_output_zeek.conf.jinja
        - so/9002_output_import.conf.jinja
        - so/9034_output_syslog.conf.jinja
        - so/9100_output_osquery.conf.jinja
        - so/9400_output_suricata.conf.jinja
        - so/9500_output_beats.conf.jinja
        - so/9600_output_ossec.conf.jinja
        - so/9700_output_strelka.conf.jinja
        - custom/9999_output_splunk_manager.conf.jinja
