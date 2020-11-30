# SecurityOnion 2.x ELKomply Guide
#### Caveats and Concerns
* Splunk receiving system **MUST** be operational **BEFORE** making configurations to Security Onion 2.x<br />
* Systems executing logstash **MUST** be able to reach Splunk, otherwise Logstash will not send **ANY** logs
    - This applies to logs destined for Elasticsearch AND Splunk and is due to the infinite retry mechanism in logstash
    - This caveat only applies once logstash pipelines have been applied
<br />

## Implementation:
#### All configurations for Security Onion 2.x platforms must be done on the Manager system
1. Replace \<splunk_ip\> in 9999_output_splunk_manager.conf.jinja with one of the following:
    - Splunk HEC port
    - NAT Firewall port (Destined for Splunk HEC port)
2. Randomize the token in the headers parameter
    - Remember to keep the xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx formatting
    - Only use lowercase hexadecimal characters (a-f and 0-9)
3. Copy the 9999_output_splunk_manager.conf.jinja to /opt/so/saltstack/local/salt/pipelines/config/custom/ folder
4. Add the lines in global.sls to the bottom global.sls file in the /opt/so/saltstack/local/pillar/global.sls
5. Run `salt "*" state.highstate` to push new configurations files to identified search and manager nodes
6. Run `so-status` on manager and search nodes to verify Logstash **OK** status

## References:<br />
*HTTP Event Collector Loagstash Example: https://discuss.elastic.co/t/logstash-to-splunk-http-event-collector/130765/6*<br />
*Logstash Adding New Logs: https://docs.securityonion.net/en/latest/logstash.html?ls#adding-new-logs*<br />
*Logstash Parsing (Salt): https://docs.securityonion.net/en/latest/logstash.html?#logstash-parsing*<br />
*Salt Modules (Calling Highstate): https://docs.saltstack.com/en/3000/ref/modules/all/salt.modules.state.html*<br />
*Salt Distributed Environments: https://docs.securityonion.net/en/latest/soup.html?#distributed-deployments*<br />
