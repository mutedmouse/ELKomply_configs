# HELK ELKomply Guide
#### Caveats and Concerns
* Splunk receiving system **MUST** be operational **BEFORE** making configurations to HELK<br />
* Systems executing logstash **MUST** be able to reach Splunk, otherwise Logstash will not send **ANY** logs
    - This applies to logs destined for Elasticsearch AND Splunk and is due to the infinite retry mechanism in logstash
    - This caveat only applies once logstash pipelines have been applied
* This guide will make use of a variable HELK_HOMEDIR, this variable represents the location when you downloaded HELK to during the installation phase
    - for example: HELK_HOMEDIR on the testing system was /home/admin/HELK/
    - subfolders would be annotated as HELK_HOMEDIR/docker/helk-logstash
    
## Implementation:
#### All configurations for HELK platforms must be done on HELK logstash systems
1. Replace \<splunk_ip\> in 9999_helk_splunk.conf with one of the following:
    - Splunk HEC port
    - NAT Firewall port (Destined for Splunk HEC port)
2. Randomize the token in the headers parameter
    - Remember to keep the xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx formatting
    - Only use lowercase hexadecimal characters (a-f and 0-9)
    - Remember to record this token and place it in the /opt/splunk/etc/apps/ELKomply/default/inputs.conf file, under the \[helk\] stanza
3. Copy the 9999_helk_splunk.conf to  folder
4. Restarting the system running helk is the simplest way to reload the logstash docker. Alternatively you perform the following:
    - change directory to the HELK_HOMEDIR/docker folder
    - execute `docker-compose -f <installation_option>.yml restart`
    - replace \<installation_option\>.yml with your installation version, testing system this version was helk-kibana-notebook-analysis-alert-basic.yml
5. Run `docker-compose -f <installation_option>.yml ps` to verify Logstash is **UP**
6. Run `watch -d -n3 "docker ps | grep logstash"` and verify container is restarting continuously

## References:<br />
*HELK Architecture: https://github.com/Cyb3rWard0g/HELK/wiki/Architecture-Overview*<br />
*HELK Installation Guide: https://github.com/Cyb3rWard0g/HELK/wiki/Installation*<br />
*HTTP Event Collector Loagstash Example: https://discuss.elastic.co/t/logstash-to-splunk-http-event-collector/130765/6*<br />

