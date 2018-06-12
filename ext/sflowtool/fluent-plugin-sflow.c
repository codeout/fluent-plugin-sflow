#include "ruby.h"
#include "sflow.h"
#include "arpa/inet.h"

#include <stdio.h>


void receiveSFlowDatagram();
void detectAddressFamily(char *addr, SFSample *sample);
void rawshark_init();


VALUE wrap_receiveSFlowDatagram(self, data, exporter)
  VALUE self, data, exporter;
{
  SFSample sample;
  char *addr;

  memset(&sample, 0, sizeof(sample));
  sample.json = rb_str_new(0, 0);

  sample.rawSample = (uint8_t *)StringValuePtr(data);
  sample.rawSampleLen = (int)RSTRING_LEN(data);

  addr = StringValuePtr(exporter);
  detectAddressFamily(addr, &sample);

  receiveSFlowDatagram(&sample);

  return sample.json;
}

void detectAddressFamily(char *addr, SFSample *sample)
{
  unsigned char buf[sizeof(struct in6_addr)];

  /* NOTE: See static void receivePacket(int soc) */
  if(inet_pton(AF_INET, addr, buf)) {
    sample->sourceIP.type = SFLADDRESSTYPE_IP_V4;
    memcpy(&sample->sourceIP.address.ip_v4, buf, 4);
  } else if(inet_pton(AF_INET6, addr, buf)) {
    sample->sourceIP.type = SFLADDRESSTYPE_IP_V6;
    memcpy(&sample->sourceIP.address.ip_v6.addr, buf, 16);
  }
}

void Init_sflowtool()
{
  VALUE module;

  module = rb_define_module("Sflowtool");
  rb_define_module_function(module, "receive_sflow_datagram", wrap_receiveSFlowDatagram, 2);

  // FIXME: This won't be cleaned
  rawshark_init();

  // rawshark_clean();
  // edt = NULL;
}
