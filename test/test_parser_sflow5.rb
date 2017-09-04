require 'fluent/test'
require 'test/unit'

require 'fluent/plugin/parser_sflow'


class ParserSflow5Test < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end


  def parser
    Fluent::Plugin::SflowParser.new
  end


  test 'parse sflow v5 flow sample of IPv4 packet without vlan' do
    data = File.binread(File.expand_path('../dump/sflow.v5.ipv4_without_vlan.dump', __FILE__))

    parsed = []
    parser.parse(data, '10.1.2.1') do |time, record|
      parsed << [time, record]
    end

    assert_equal 1, parsed.size
    assert parsed.first[0] - Time.now.to_i < 1

    {
      'datagram_source_ip'  =>  '10.1.2.1',
      'unix_seconds_utc' => parsed.first[0],
      'datagram_version' => 5,
      'agent' => '10.1.2.1',
      'samples_in_packet' => 1,
      'sample_type' => 'flow_sample',

      'input_port' => 513,
      'output_port' => 512,
      'dst_mac' => '020586717d03',
      'src_mac' => '080027129909',
      'ip_size' => 84,
      'ip_tot_len' => 84,
      'src_ip' => '10.1.2.2',
      'dst_ip' => '1.0.4.1',
      'ip_protocol' => 1,
      'icmp_type' => 8,
      'icmp_code' => 0,
      'in_vlan' => 0,
      'out_vlan' => 0,
      'next_hop' => '202.249.2.169',
      'src_subnet_mask' => 32,
      'dst_subnet_mask' => 22
    }.each do |key, expected|
      assert_equal expected, parsed.first[1][key]
    end
  end

  test 'parse sflow v5 counters sample' do
    data = File.binread(File.expand_path('../dump/sflow.v5.counters.dump', __FILE__))

    parsed = []
    parser.parse(data, '10.1.2.1') do |time, record|
      parsed << [time, record]
    end

    assert_equal 1, parsed.size
    assert parsed.first[0] - Time.now.to_i < 1

    {
      'datagram_source_ip' => '10.1.2.1',
      'unix_seconds_utc' => parsed.first[0],
      'datagram_version' => 5,
      'agent' => '10.1.2.1',
      'samples_in_packet' => 1,
      'sample_type' => 'counters_sample',

      'if_index' => 512,
      'network_type' => 6,
      'if_speed' => 10000000000,
      'if_direction' => 1,
      'if_status' => 3,
      'if_in_octets' => 0,
      'if_in_ucast_pkts' => 8,
      'if_in_multicast_pkts' => 121,
      'if_in_broadcast_pkts' => 0,
      'if_in_discards' => 0,
      'if_in_errors' => 0,
      'if_in_unknown_protos' => 0,
      'if_out_octets' => 130454,
      'if_out_ucast_pkts' => 1060,
      'if_out_multicast_pkts' => 0,
      'if_out_broadcast_pkts' => 95,
      'if_out_discards' => 0,
      'if_out_errors' => 0,
      'if_promiscuous_mode' => 0,
      'dot3_stats_alignment_errors' => 0,
      'dot3_stats_fcserrors' => 0,
      'dot3_stats_single_collision_frames' => 0,
      'dot3_stats_multiple_collision_frames' => 0,
      'dot3_stats_sqetest_errors' => 0,
      'dot3_stats_deferred_transmissions' => 0,
      'dot3_stats_late_collisions' => 0,
      'dot3_stats_excessive_collisions' => 0,
      'dot3_stats_internal_mac_transmit_errors' => 0,
      'dot3_stats_carrier_sense_errors' => 0,
      'dot3_stats_frame_too_longs' => 0,
      'dot3_stats_internal_mac_receive_errors' => 0,
      'dot3_stats_symbol_errors' => 0
    }.each do |key, expected|
      assert_equal expected, parsed.first[1][key]
    end
  end
end
