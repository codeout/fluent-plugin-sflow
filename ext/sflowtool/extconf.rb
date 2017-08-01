require 'mkmf'

SFLOWTOOL_VERSION = 3.41


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
end


create_makefile('sflowtool')
