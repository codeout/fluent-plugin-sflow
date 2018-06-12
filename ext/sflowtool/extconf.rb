require 'mkmf'

SFLOWTOOL_VERSION = 3.41
WIRESHARK_VERSION = '2.4.6'

# $CFLAGS += ' -g'
$CFLAGS += ' ' + `pkg-config --cflags glib-2.0`.strip
$CFLAGS += " -I. -I./wireshark-#{WIRESHARK_VERSION} -I./wireshark-#{WIRESHARK_VERSION}/epan"
$LDFLAGS += ' -lwiretap -lwireshark -lwsutil -lglib-2.0'

have_header('sflow.h')
%w(fcntl.h netdb.h netinet/in.h stdlib.h string.h sys/socket.h sys/time.h unistd.h).each do |h|
  have_header h
end

%w(ruby.h alpa/socket.h).each do |h|
  have_header h
end


%w(getaddrinfo memset select socket strdup strerror strspn strtol).each do |f|
  have_func f
end


create_header('config.h')
File.open('config.h', 'ab') do |f|
  f.puts %(#define VERSION "#{SFLOWTOOL_VERSION}")
  f.puts "#define WS_NORETURN __attribute((noreturn))"
  f.puts "#define WTAP_FILE_UNKNOWN 0"
  f.puts "#define WTAP_MAX_PACKET_SIZE 65535"
  f.puts "#define _U_ __attribute__((unused))"
end


create_makefile('sflowtool/sflowtool')


["wget https://www.wireshark.org/download/src/all-versions/wireshark-#{WIRESHARK_VERSION}.tar.xz",
 "tar xf wireshark-#{WIRESHARK_VERSION}.tar.xz",
 "rm wireshark-#{WIRESHARK_VERSION}.tar.xz"].each do |cmd|
  system(cmd)
end
