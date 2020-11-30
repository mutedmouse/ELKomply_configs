# SecurityOnion 16.x ELKomply Guide
#### Caveats and Concerns
* Splunk receiving system **MUST** be operational **BEFORE** making configurations to Security Onion 16.x<br />
* Systems executing logstash **MUST** be able to reach Splunk, otherwise Logstash will not send **ANY** logs
    - This applies to logs destined for Elasticsearch AND Splunk and is due to the infinite retry mechanism in logstash
    - This caveat only applies once logstash pipelines have been applied
* This configuration should **ONLY** be implemented on systems **NOT** running logstash in minimal mode
    - See References below for documentation on how to change this setting
    - Logstash minimal is default in later version of SecurityOnion 16.x, and should be disabled
* Light Forwarders **DO NOT** require this configuration as they do not run logstash instances
<br />

## Implementation:
#### All configurations for Security Onion 16.x platforms must be done on the each HEAVY FORWARDER and MASTER device
1. Replace \<splunk_ip\> in 9997_securityonion_splunk.conf with one of the following:
    - Splunk HEC port
    - NAT Firewall port (Destined for Splunk HEC port)
2. Randomize the token in the headers parameter
    - Remember to keep the xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx formatting
    - Only use lowercase hexadecimal characters (a-f and 0-9)
3. Copy the 9997_securityonion_splunk.conf to /etc/logstash/custom/ folder
4. Execute `sudo so-logstash-restart && sudo tail -f /var/log/logstash/logstash.log` on the current Heavy Forwarder or Master
6. Run `so-status` on the current Heavy Forwarder or Master to verify Logstash **OK** status

## References:<br />
*Logstash Minimal mode documentation: https://docs.securityonion.net/en/16.04/logstash.html?logstash-minimal*<br />
*HTTP Event Collector Loagstash Example: https://discuss.elastic.co/t/logstash-to-splunk-http-event-collector/130765/6*<br />
*Logstash Adding New Logs: https://docs.securityonion.net/en/16.04/logstash.html?#parsing*<br />
<br /><br />
**Contributions to this readme are credited to Chris Burch (packetsneaker@gmail.com)**
