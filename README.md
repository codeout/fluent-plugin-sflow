# fluent-plugin-sflow

[![Build Status](https://travis-ci.org/codeout/fluent-plugin-sflow.svg?branch=master)](https://travis-ci.org/codeout/fluent-plugin-sflow)

## This branch is valid only for Fluentd 0.12.40 or later

See [0.14.x branch](https://github.com/codeout/fluent-plugin-sflow/tree/fluentd-0.14) for Fluentd 0.14.x.

## Overview

[Fluentd](http://fluentd.org/) input plugin that acts as sFlow v2/v4/v5 collector.

Including a ruby wrapper of [sflowtool](http://www.inmon.com/technology/sflowTools.php) which processes sFlow datagrams to report in JSON format.


## Features

fluent-plugin-sflow supports many packet formats below. Basically, it can process anything sflowtool can do. :sparkles:

See [sflowtool document](http://www.inmon.com/technology/sflowTools.php) for more details.

### Sample Type

* Flow Sample
* Counter Sample

### Address Family

* IPv4
* IPv6

### Extended Data Type

* Switch
* Router
* Gateway_v2
* Gateway
* User
* Url
* mplsLabelStack
* Mpls
* Nat
* NatPort
* MplsTunnel
* MplsVC
* MplsFTN
* MplsLDP_FEC
* VlanTunnel
* WifiPayload
* WifiRx
* WifiTx
* Aggregation
* Socket4
* ProxySocket4
* Socket6
* ProxySocket6
* Decap
* VNI
* TCPInfo

### Counter Data Type

* ethernet
* tokenring
* vg
* vlan
* 80211
* processor
* radio
* OFPort
* portName
* OVSDP
* host_hid
* adaptors
* host_parent
* host_cpu
* host_mem
* host_dsk
* host_nio
* host_ip
* host_icmp
* host_tcp
* host_udp
* host_vnode
* host_vcpu
* host_vmem
* host_vdsk
* host_vnio
* host_gpu_nvml
* bcm_tables
* memcache
* memcache2
* http
* JVM
* JMX
* APP
* APP_RESOURCE
* APP_WORKERS
* VDI
* LACP
* SFP


## Requirement

* Fluentd: 0.12.40 or later
* See [0.14.x branch](https://github.com/codeout/fluent-plugin-sflow/tree/fluentd-0.14) for Fluentd 0.14.x.

## Install

``` shell
$ gem install fluent-plugin-sflow -v '~> 0.2.0'
```

You can also use ```fluent-gem``` or ```td-agent-gem``` instead of ```gem``` command.


## Configuration

```
<source>
  @type sflow
  tag example.sflow

  bind 0.0.0.0
  port 6343
</source>
```

**bind**

IP address on which this plugin will accept sFlow.
(Default: '0.0.0.0')

**port**

UDP port number on which this plugin will accept sFlow.
(Default: 6343)


## Record Example

### Flow Sample

``` javascript
{
  "datagram_source_ip": "10.1.2.1",
  "datagram_size": 240,
  "unix_seconds_utc": 1502113217,
  "datagram_version": 5,
  "agent_sub_id": 0,
  "agent": "10.1.2.1",
  "packet_sequence_no": 53,
  "sys_up_time": 3808877,
  "samples_in_packet": 1,
  "sample_type_tag": "0:1",
  "sample_type": "flow_sample",
  "sample_sequence_no": 44,
  "source_id": "0:513",
  "mean_skip_count": 5,
  "sample_pool": 225,
  "drop_events": 0,
  "input_port": 513,
  "output_port": 512,
  "flow_block_tag": "0:1002",
  "header_protocol": 1,
  "sampled_packet_size": 102,
  "stripped_bytes": 4,
  "header_len": 98,
  "header_bytes": "02-05-86-71-7D-03-08-00-27-12-99-09-08-00-45-00-00-54-B0-61-40-00-40-01-79-44-0A-01-02-02-01-00-04-01-08-00-DF-97-04-12-03-AD-D2-1A-87-59-00-00-00-00-F6-61-02-00-00-00-00-00-10-11-12-13-14-15-16-17-18-19-1A-1B-1C-1D-1E-1F-20-21-22-23-24-25-26-27-28-29-2A-2B-2C-2D-2E-2F-30-31-32-33-34-35-36-37",
  "dst_mac": "020586717d03",
  "src_mac": "080027129909",
  "ip_size": 84,
  "ip_tot_len": 84,
  "src_ip": "10.1.2.2",
  "dst_ip": "1.0.4.1",
  "ip_protocol": 1,
  "ip_tos": 0,
  "ip_ttl": 64,
  "ip_id": 25008,
  "icmp_type": 8,
  "icmp_code": 0,
  "in_vlan": 0,
  "in_priority": 0,
  "out_vlan": 0,
  "out_priority": 0,
  "next_hop": "202.249.2.169",
  "src_subnet_mask": 32,
  "dst_subnet_mask": 22
}
```

### Counters Sample

``` javascript
{
  "datagram_source_ip": "10.1.2.1",
  "datagram_size": 204,
  "unix_seconds_utc": 1502113415,
  "datagram_version": 5,
  "agent_sub_id": 0,
  "agent": "10.1.2.1",
  "packet_sequence_no": 54,
  "sys_up_time": 3810403,
  "samples_in_packet": 1,
  "sample_type_tag": "0:2",
  "sample_type": "counters_sample",
  "sample_sequence_no": 5,
  "source_id": "0:512",
  "counter_block_tag": "0:2",
  "if_index": 512,
  "network_type": 6,
  "if_speed": 10000000000,
  "if_direction": 1,
  "if_status": 3,
  "if_in_octets": 0,
  "if_in_ucast_pkts": 8,
  "if_in_multicast_pkts": 121,
  "if_in_broadcast_pkts": 0,
  "if_in_discards": 0,
  "if_in_errors": 0,
  "if_in_unknown_protos": 0,
  "if_out_octets": 130454,
  "if_out_ucast_pkts": 1060,
  "if_out_multicast_pkts": 0,
  "if_out_broadcast_pkts": 95,
  "if_out_discards": 0,
  "if_out_errors": 0,
  "if_promiscuous_mode": 0,
  "dot3_stats_alignment_errors": 0,
  "dot3_stats_fcserrors": 0,
  "dot3_stats_single_collision_frames": 0,
  "dot3_stats_multiple_collision_frames": 0,
  "dot3_stats_sqetest_errors": 0,
  "dot3_stats_deferred_transmissions": 0,
  "dot3_stats_late_collisions": 0,
  "dot3_stats_excessive_collisions": 0,
  "dot3_stats_internal_mac_transmit_errors": 0,
  "dot3_stats_carrier_sense_errors": 0,
  "dot3_stats_frame_too_longs": 0,
  "dot3_stats_internal_mac_receive_errors": 0,
  "dot3_stats_symbol_errors": 0
}
```

## Benchmark

Here is a quick benchmark on Macbook Pro Mid 2015:

* sFlow v5 flow samples, 5.88 samples per packet in average
* Fluentd v0.12.40
* 14202 sFlow v5 records/s


## TODO

* Add more tests
  * Please send me the sFlow pcap file if your device is not supported. :cyclone:
    1. Archive your pcap in .zip or .gz
    2. [Open a new issue](https://github.com/codeout/fluent-plugin-sflow/issues/new)
    3. Attach the archive


## Contributing

Please report issues or enhancement requests to [GitHub issues](https://github.com/codeout/fluent-plugin-sflow/issues).
For questions or feedbacks write to my twitter @codeout.

Or send a pull request to fix.


## Copyright and License

Copyright (c) 2017 Shintaro Kojima. Code released under the [MIT license](LICENSE.txt).

Code includes a part of [sflowtool](http://www.inmon.com/technology/sflowTools.php) which is distributed in the [InMon sFlow License](http://www.inmon.com/technology/sflowlicense.txt).
