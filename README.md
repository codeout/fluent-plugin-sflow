# fluent-plugin-sflow

## Overview

[Fluentd](http://fluentd.org/) input plugin that acts as sFlow v2/v4/v5 collector.

Including a ruby wrapper of [sflowtool](http://www.inmon.com/technology/sflowTools.php) which processes sFlow datagrams to report in JSON format.


## Features

fluent-plugin-sflow supports many packet formats below. Basically it can process anything sflowtool can do. :sparkles:

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


## Install


## Configuration


## Record Example


## Benchmark


## TODO

* Add more tests
  * Please send me the sFlow pcap file if your device is not supporeted. :cyclone:
    1. Archive your pcap in .zip or .gz
    2. [Open a new issue](https://github.com/codeout/fluent-plugin-sflow/issues/new)
    3. Attache the archive
* Merge into [RubyGem](https://rubygems.org/gems/fluent-plugin-sflow).


## Contributing

Please report issues or enhancement requests to [GitHub issues](https://github.com/codeout/fluent-plugin-sflow/issues).
For questions or feedbacks write to my twitter @codeout.

Or send a pull request to fix.


## Copyright and License

Copyright (c) 2017 Shintaro Kojima. Code released under the [MIT license](LICENSE.txt).

Code includes a part of [sflowtool](http://www.inmon.com/technology/sflowTools.php) which is distributed in the [InMon sFlow License](http://www.inmon.com/technology/sflowlicense.txt).
