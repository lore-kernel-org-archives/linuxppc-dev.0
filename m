Date: Wed, 15 Oct 2003 10:09:04 -0500
Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Ken Offer <koffer@arlut.utexas.edu>
In-Reply-To: <1066205955.644.55.camel@gaston>
Message-Id: <83C80826-FF21-11D7-B3CC-000393467F1A@arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday, October 15, 2003, at 03:19  AM, Benjamin Herrenschmidt
wrote:

>
>> Hi Jens,
>>
>> I'm trying that myself, but I'm running into undefined symbols, plus
>> problems with compiling PCNET32 (whatever that is).
>>
>> I started with the ".config" file copied from
>> "arch/ppc/configs/pmac_defconfig", but that might not be the best.
>> I'm
>> not sure how all the creative config names map to specific machines,
>> like the PowerBook.
>>
>> What config file did you compile 2.5-benh with?
>
> The pmac_defconfig should be correct. pcnet32 is known to have problems
> in current 2.6 though, just disable it. What undefined symbols do you
> have ?
>
> Ben.

Hi Ben,

Below are the warnings I get with "make modules_install" and your
2.6.0-test7 kernel using the pmac_defconfig config file with pcnet32
turned off.  This was compiled with gcc 3.2.2.

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test7;
fi
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/i2c/busses/i2c-keywest.ko
depmod:         i2c_smbus_xfer
depmod:         i2c_add_adapter
depmod:         i2c_del_adapter
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/i2c/i2c-dev.ko
depmod:         i2c_master_send
depmod:         i2c_transfer
depmod:         i2c_smbus_xfer
depmod:         i2c_del_driver
depmod:         i2c_get_functionality
depmod:         i2c_check_addr
depmod:         i2c_control
depmod:         i2c_get_adapter
depmod:         i2c_put_adapter
depmod:         i2c_master_recv
depmod:         i2c_add_driver
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/ide/legacy/ide-cs.ko
depmod:         cs_error
depmod:         pcmcia_unregister_driver
depmod:         pcmcia_register_driver
depmod:         CardServices
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/ieee1394/dv1394.ko
depmod:         ieee1394_bus_type
depmod:         ohci1394_init_iso_tasklet
depmod:         ohci1394_unregister_iso_tasklet
depmod:         hpsb_register_highlevel
depmod:         hpsb_unregister_highlevel
depmod:         dma_region_mmap
depmod:         dma_region_init
depmod:         ohci1394_register_iso_tasklet
depmod:         dma_region_offset_to_bus
depmod:         hpsb_register_protocol
depmod:         ieee1394_unregister_chardev
depmod:         hpsb_unregister_protocol
depmod:         dma_region_alloc
depmod:         ieee1394_register_chardev
depmod:         dma_region_sync
depmod:         dma_region_free
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/ieee1394/eth1394.ko
depmod:         hpsb_iso_recv_init
depmod:         hpsb_register_highlevel
depmod:         hpsb_unregister_highlevel
depmod:         hpsb_destroy_hostinfo
depmod:         hpsb_send_packet
depmod:         highlevel_host_reset
depmod:         hpsb_set_packet_complete_task
depmod:         alloc_hpsb_packet
depmod:         hpsb_iso_recv_release_packets
depmod:         hpsb_iso_n_ready
depmod:         hpsb_get_tlabel
depmod:         hpsb_get_hostinfo
depmod:         free_hpsb_packet
depmod:         hpsb_iso_shutdown
depmod:         hpsb_iso_recv_start
depmod:         hpsb_packet_success
depmod:         hpsb_free_tlabel
depmod:         hpsb_create_hostinfo
depmod:         hpsb_guid_get_entry
depmod:         hpsb_register_addrspace
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/ieee1394/ohci1394.ko
depmod:         dma_prog_region_alloc
depmod:         dma_prog_region_init
depmod:         hpsb_packet_sent
depmod:         hpsb_bus_reset
depmod:         hpsb_selfid_complete
depmod:         dma_prog_region_free
depmod:         dma_region_offset_to_bus
depmod:         hpsb_add_host
depmod:         hpsb_iso_wake
depmod:         hpsb_packet_received
depmod:         hpsb_alloc_host
depmod:         hpsb_remove_host
depmod:         hpsb_selfid_received
depmod:         hpsb_unref_host
depmod:         hpsb_iso_packet_sent
depmod:         dma_region_sync
depmod:         hpsb_iso_packet_received
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/ieee1394/raw1394.ko
depmod:         hpsb_iso_recv_init
depmod:         ieee1394_bus_type
depmod:         hpsb_make_readpacket
depmod:         hpsb_iso_stop
depmod:         hpsb_iso_recv_set_channel_mask
depmod:         hpsb_register_highlevel
depmod:         hpsb_unregister_highlevel
depmod:         hpsb_iso_recv_listen_channel
depmod:         dma_region_mmap
depmod:         hpsb_send_packet
depmod:         hpsb_make_lock64packet
depmod:         hpsb_make_writepacket
depmod:         hpsb_make_lockpacket
depmod:         hpsb_set_packet_complete_task
depmod:         alloc_hpsb_packet
depmod:         hpsb_iso_recv_flush
depmod:         hpsb_iso_xmit_sync
depmod:         hpsb_iso_recv_release_packets
depmod:         hpsb_register_protocol
depmod:         hpsb_iso_n_ready
depmod:         ieee1394_unregister_chardev
depmod:         hpsb_reset_bus
depmod:         hpsb_ref_host
depmod:         hpsb_make_phypacket
depmod:         hpsb_unlisten_channel
depmod:         hpsb_unregister_protocol
depmod:         hpsb_unregister_addrspace
depmod:         hpsb_unref_host
depmod:         hpsb_listen_channel
depmod:         hpsb_make_streampacket
depmod:         hpsb_get_config_rom
depmod:         hpsb_update_config_rom
depmod:         free_hpsb_packet
depmod:         hpsb_iso_recv_unlisten_channel
depmod:         hpsb_iso_xmit_queue_packet
depmod:         hpsb_iso_shutdown
depmod:         hpsb_iso_recv_start
depmod:         hpsb_free_tlabel
depmod:         ieee1394_register_chardev
depmod:         hpsb_iso_xmit_init
depmod:         hpsb_register_addrspace
depmod:         hpsb_iso_xmit_start
depmod:         hpsb_make_isopacket
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/ieee1394/sbp2.ko
depmod:         ieee1394_bus_type
depmod:         hpsb_register_highlevel
depmod:         hpsb_unregister_highlevel
depmod:         hpsb_speedto_str
depmod:         hpsb_destroy_hostinfo
depmod:         hpsb_send_packet
depmod:         hpsb_set_hostinfo_key
depmod:         hpsb_make_writepacket
depmod:         hpsb_set_packet_complete_task
depmod:         hpsb_node_fill_packet
depmod:         hpsb_node_write
depmod:         hpsb_register_protocol
depmod:         hpsb_get_hostinfo_bykey
depmod:         hpsb_unregister_protocol
depmod:         hpsb_get_hostinfo
depmod:         free_hpsb_packet
depmod:         hpsb_get_host_bykey
depmod:         hpsb_free_tlabel
depmod:         hpsb_create_hostinfo
depmod:         hpsb_register_addrspace
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/ieee1394/video1394.ko
depmod:         ieee1394_bus_type
depmod:         ohci1394_init_iso_tasklet
depmod:         ohci1394_unregister_iso_tasklet
depmod:         dma_prog_region_alloc
depmod:         hpsb_register_highlevel
depmod:         hpsb_unregister_highlevel
depmod:         dma_region_mmap
depmod:         dma_prog_region_init
depmod:         hpsb_set_hostinfo_key
depmod:         dma_region_init
depmod:         dma_prog_region_free
depmod:         hpsb_set_hostinfo
depmod:         ohci1394_register_iso_tasklet
depmod:         dma_region_offset_to_bus
depmod:         hpsb_register_protocol
depmod:         hpsb_get_hostinfo_bykey
depmod:         ieee1394_unregister_chardev
depmod:         hpsb_unregister_protocol
depmod:         hpsb_get_hostinfo
depmod:         ohci1394_stop_context
depmod:         dma_region_alloc
depmod:         hpsb_create_hostinfo
depmod:         ieee1394_register_chardev
depmod:         dma_region_free
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/net/irda/irtty-sir.ko
depmod:         sirdev_get_instance
depmod:         sirdev_receive
depmod:         sirdev_write_complete
depmod:         sirdev_set_dongle
depmod:         sirdev_put_instance
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/net/irda/sir-dev.ko
depmod:         irlap_close
depmod:         irda_init_max_qos_capabilies
depmod:         async_wrap_skb
depmod:         irlap_open
depmod:         async_unwrap_char
depmod:         irda_qos_bits_to_value
depmod:         irda_device_set_media_busy
depmod:         alloc_irdadev
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/net/wireless/airport.ko
depmod:         hermes_struct_init
depmod:         alloc_orinocodev
depmod:         orinoco_reinit_firmware
depmod:         orinoco_interrupt
depmod:         __orinoco_down
depmod:         __orinoco_up
depmod:         hermes_init
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/net/wireless/orinoco.ko
depmod:         hermes_write_ltv
depmod:         hermes_bap_pread
depmod:         hermes_read_ltv
depmod:         hermes_bap_pwrite
depmod:         hermes_allocate
depmod:         hermes_docmd_wait
depmod:         hermes_init
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/net/wireless/orinoco_cs.ko
depmod:         hermes_struct_init
depmod:         alloc_orinocodev
depmod:         orinoco_reinit_firmware
depmod:         orinoco_interrupt
depmod:         __orinoco_down
depmod:         pcmcia_unregister_driver
depmod:         pcmcia_register_driver
depmod:         __orinoco_up
depmod:         CardServices
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/pcmcia/ds.ko
depmod:         pcmcia_access_configuration_register
depmod:         pcmcia_suspend_card
depmod:         pcmcia_eject_card
depmod:         pcmcia_deregister_client
depmod:         pcmcia_register_client
depmod:         pcmcia_get_socket_by_nr
depmod:         pcmcia_get_next_window
depmod:         pcmcia_resume_card
depmod:         pcmcia_socket_class
depmod:         pcmcia_parse_tuple
depmod:         pcmcia_reset_card
depmod:         pcmcia_get_configuration_info
depmod:         pcmcia_get_first_region
depmod:         pcmcia_adjust_resource_info
depmod:         pcmcia_get_next_region
depmod:         pcmcia_bind_mtd
depmod:         pcmcia_get_tuple_data
depmod:         pcmcia_bind_device
depmod:         pcmcia_get_mem_page
depmod:         pcmcia_get_card_services_info
depmod:         pcmcia_get_first_tuple
depmod:         pcmcia_report_error
depmod:         pcmcia_get_next_tuple
depmod:         pcmcia_get_first_window
depmod:         pcmcia_insert_card
depmod:         pcmcia_replace_cis
depmod:         pcmcia_lookup_bus
depmod:         pcmcia_validate_cis
depmod:         pcmcia_get_status
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/pcmcia/i82092.ko
depmod:         pcmcia_parse_events
depmod:         pcmcia_register_socket
depmod:         dead_socket
depmod:         pcmcia_socket_dev_suspend
depmod:         pcmcia_unregister_socket
depmod:         pcmcia_socket_dev_resume
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/pcmcia/tcic.ko
depmod:         pcmcia_parse_events
depmod:         pcmcia_register_socket
depmod:         dead_socket
depmod:         pcmcia_socket_dev_suspend
depmod:         pcmcia_unregister_socket
depmod:         pcmcia_socket_dev_resume
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/pcmcia/yenta_socket.ko
depmod:         pcmcia_parse_events
depmod:         pcmcia_register_socket
depmod:         dead_socket
depmod:         pcmcia_socket_dev_suspend
depmod:         pcmcia_unregister_socket
depmod:         pcmcia_socket_dev_resume
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/serial/8250_pci.ko
depmod:         serial8250_resume_port
depmod:         serial8250_suspend_port
depmod:         unregister_serial
depmod:         register_serial
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/serial/serial_cs.ko
depmod:         cs_error
depmod:         pcmcia_unregister_driver
depmod:         pcmcia_register_driver
depmod:         CardServices
depmod:         unregister_serial
depmod:         register_serial
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/drivers/usb/serial/visor.ko
depmod:         usb_serial_deregister
depmod:         usb_serial_register
depmod:         usb_serial_probe
depmod:         usb_serial_disconnect
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/fs/msdos/msdos.ko
depmod:         fat_scan
depmod:         fat_dir_empty
depmod:         fat_add_entries
depmod:         fat_notify_change
depmod:         fat_date_unix2dos
depmod:         fat_build_inode
depmod:         fat_detach
depmod:         fat_attach
depmod:         fat_new_dir
depmod:         fat_fill_super
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/fs/vfat/vfat.ko
depmod:         fat_scan
depmod:         fat_dir_empty
depmod:         fat_add_entries
depmod:         fat__get_entry
depmod:         fat_notify_change
depmod:         fat_date_unix2dos
depmod:         fat_build_inode
depmod:         fat_search_long
depmod:         fat_detach
depmod:         fat_attach
depmod:         fat_new_dir
depmod:         fat_fill_super
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/arpt_mangle.ko
depmod:         arpt_unregister_target
depmod:         arpt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/arptable_filter.ko
depmod:         arpt_register_table
depmod:         arpt_do_table
depmod:         arpt_unregister_table
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ip_nat_amanda.ko
depmod:         needs_ip_conntrack_amanda
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ip_nat_ftp.ko
depmod:         needs_ip_conntrack_ftp
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ip_nat_irc.ko
depmod:         needs_ip_conntrack_irc
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_MASQUERADE.ko
depmod:         ipt_unregister_target
depmod:         ipt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_NETMAP.ko
depmod:         ipt_unregister_target
depmod:         ipt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_REDIRECT.ko
depmod:         ipt_unregister_target
depmod:         ipt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_REJECT.ko
depmod:         ipt_unregister_target
depmod:         ipt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_SAME.ko
depmod:         ipt_unregister_target
depmod:         ipt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_TCPMSS.ko
depmod:         ipt_unregister_target
depmod:         ipt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_ULOG.ko
depmod:         ipt_unregister_target
depmod:         ipt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_ah.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_conntrack.ko
depmod:         need_ip_conntrack
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_dscp.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_ecn.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_esp.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_helper.ko
depmod:         need_ip_conntrack
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_iprange.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_length.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_limit.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_mac.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_mark.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_multiport.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_owner.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_pkttype.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_recent.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_state.ko
depmod:         need_ip_conntrack
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_tcpmss.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_tos.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/ipt_ttl.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/iptable_filter.ko
depmod:         ipt_unregister_table
depmod:         ipt_do_table
depmod:         ipt_register_table
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/ipv4/netfilter/iptable_nat.ko
depmod:         ipt_unregister_table
depmod:         need_ip_conntrack
depmod:         ipt_do_table
depmod:         ipt_unregister_target
depmod:         ipt_register_table
depmod:         ipt_register_target
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/irda/ircomm/ircomm-tty.ko
depmod:         iriap_getvaluebyclass_request
depmod:         irda_notify_init
depmod:         ircomm_connect_response
depmod:         ircomm_connect_request
depmod:         irlmp_unregister_service
depmod:         ircomm_control_request
depmod:         hashbin_get_next
depmod:         irlmp_register_service
depmod:         irias_add_integer_attrib
depmod:         hashbin_new
depmod:         irias_insert_object
depmod:         hashbin_insert
depmod:         hashbin_get_first
depmod:         irias_new_object
depmod:         irias_delete_value
depmod:         ircomm_close
depmod:         hashbin_lock_find
depmod:         irda_param_insert
depmod:         hashbin_delete
depmod:         irlmp_discovery_request
depmod:         ircomm_open
depmod:         irlmp_register_client
depmod:         ircomm_data_request
depmod:         ircomm_disconnect_request
depmod:         irda_param_pack
depmod:         irias_add_octseq_attrib
depmod:         irias_delete_object
depmod:         irda_param_extract_all
depmod:         irlmp_service_to_hint
depmod:         iriap_close
depmod:         irlmp_unregister_client
depmod:         irda_start_timer
depmod:         iriap_open
depmod:         ircomm_flow_request
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/irda/ircomm/ircomm.ko
depmod:         irttp_open_tsap
depmod:         irda_notify_init
depmod:         irttp_connect_response
depmod:         hashbin_get_next
depmod:         irttp_data_request
depmod:         irlmp_open_lsap
depmod:         irttp_disconnect_request
depmod:         irlmp_close_lsap
depmod:         hashbin_new
depmod:         hashbin_insert
depmod:         hashbin_get_first
depmod:         irlmp_connect_response
depmod:         hashbin_lock_find
depmod:         proc_irda
depmod:         irttp_close_tsap
depmod:         hashbin_delete
depmod:         irlmp_disconnect_request
depmod:         irttp_flow_request
depmod:         irlmp_data_request
depmod:         irlmp_connect_request
depmod:         hashbin_remove
depmod:         irttp_connect_request
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/irda/irlan/irlan.ko
depmod:         irttp_open_tsap
depmod:         iriap_getvaluebyclass_request
depmod:         irda_notify_init
depmod:         irlmp_unregister_service
depmod:         irttp_connect_response
depmod:         irttp_data_request
depmod:         irlmp_register_service
depmod:         irttp_udata_request
depmod:         irttp_disconnect_request
depmod:         irias_object_change_attribute
depmod:         irias_add_integer_attrib
depmod:         irias_insert_object
depmod:         irias_new_object
depmod:         irias_delete_value
depmod:         irias_new_integer_value
depmod:         irias_add_string_attrib
depmod:         proc_irda
depmod:         irttp_close_tsap
depmod:         irlmp_discovery_request
depmod:         irlmp_register_client
depmod:         irlmp_get_saddr
depmod:         irlmp_get_daddr
depmod:         irlmp_service_to_hint
depmod:         iriap_close
depmod:         irias_find_object
depmod:         irlmp_unregister_client
depmod:         irda_start_timer
depmod:         iriap_open
depmod:         irttp_connect_request
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/net/irda/irnet/irnet.ko
depmod:         irttp_open_tsap
depmod:         iriap_getvaluebyclass_request
depmod:         irda_notify_init
depmod:         hashbin_find
depmod:         irlmp_unregister_service
depmod:         irttp_connect_response
depmod:         hashbin_get_next
depmod:         irttp_data_request
depmod:         irlmp_register_service
depmod:         irlmp_get_discoveries
depmod:         irttp_disconnect_request
depmod:         irias_add_integer_attrib
depmod:         irttp_dup
depmod:         irlmp_update_client
depmod:         hashbin_new
depmod:         irias_insert_object
depmod:         hashbin_insert
depmod:         hashbin_get_first
depmod:         irias_new_object
depmod:         irias_delete_value
depmod:         proc_irda
depmod:         irttp_close_tsap
depmod:         hashbin_delete
depmod:         irlmp_register_client
depmod:         irlmp_get_saddr
depmod:         irlmp_get_daddr
depmod:         hashbin_remove_this
depmod:         irias_delete_object
depmod:         irlmp_service_to_hint
depmod:         iriap_close
depmod:         irlmp_unregister_client
depmod:         iriap_open
depmod:         irttp_connect_request
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/oss/snd-mixer-oss.ko
depmod:         snd_cards
depmod:         snd_ctl_notify
depmod:         snd_info_get_line
depmod:         snd_register_oss_device
depmod:         snd_card_file_remove
depmod:         snd_kcalloc
depmod:         snd_info_free_entry
depmod:         snd_ctl_find_id
depmod:         snd_card_file_add
depmod:         snd_info_create_card_entry
depmod:         snd_oss_info_register
depmod:         snd_mixer_oss_notify_callback
depmod:         snd_iprintf
depmod:         snd_info_register
depmod:         snd_kmalloc_strdup
depmod:         snd_unregister_oss_device
depmod:         snd_info_get_str
depmod:         snd_info_unregister
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/oss/snd-pcm-oss.ko
depmod:         snd_pcm_hw_refine
depmod:         snd_pcm_playback_ready
depmod:         snd_pcm_hw_param_value_max
depmod:         snd_info_get_line
depmod:         snd_register_oss_device
depmod:         snd_pcm_format_set_silence
depmod:         snd_card_file_remove
depmod:         snd_pcm_hw_constraints_init
depmod:         _snd_pcm_hw_params_any
depmod:         snd_pcm_format_width
depmod:         snd_pcm_build_linear_format
depmod:         snd_kcalloc
depmod:         _snd_pcm_hw_param_setinteger
depmod:         snd_pcm_open_substream
depmod:         snd_info_free_entry
depmod:         snd_card_file_add
depmod:         snd_info_create_card_entry
depmod:         snd_pcm_lib_writev
depmod:         snd_pcm_kernel_playback_ioctl
depmod:         snd_pcm_kernel_capture_ioctl
depmod:         snd_pcm_lib_readv
depmod:         snd_oss_info_register
depmod:         snd_pcm_devices
depmod:         snd_task_name
depmod:         snd_pcm_release_substream
depmod:         snd_pcm_lib_write
depmod:         snd_pcm_capture_ready
depmod:         snd_pcm_hw_constraints_complete
depmod:         snd_pcm_format_physical_width
depmod:         snd_pcm_format_unsigned
depmod:         snd_pcm_lib_read
depmod:         snd_pcm_kernel_ioctl
depmod:         snd_iprintf
depmod:         snd_pcm_format_big_endian
depmod:         snd_pcm_notify
depmod:         snd_pcm_format_linear
depmod:         snd_pcm_format_little_endian
depmod:         snd_info_register
depmod:         snd_pcm_format_signed
depmod:         _snd_pcm_hw_param_min
depmod:         snd_pcm_stop
depmod:         snd_kmalloc_strdup
depmod:         snd_pcm_hw_param_mask
depmod:         snd_pcm_hw_param_set
depmod:         snd_mixer_oss_ioctl_card
depmod:         snd_pcm_hw_param_value_min
depmod:         _snd_pcm_hw_param_set
depmod:         snd_pcm_mmap_data
depmod:         snd_pcm_hw_param_near
depmod:         snd_unregister_oss_device
depmod:         snd_info_get_str
depmod:         snd_info_unregister
depmod:         snd_pcm_format_silence_64
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/seq/oss/snd-seq-oss.ko
depmod:         snd_midi_event_decode
depmod:         snd_seq_delete_kernel_client
depmod:         snd_seq_kernel_client_write_poll
depmod:         snd_seq_root
depmod:         snd_register_oss_device
depmod:         snd_seq_device_unregister_driver
depmod:         snd_seq_create_kernel_client
depmod:         snd_kcalloc
depmod:         snd_info_create_module_entry
depmod:         snd_info_free_entry
depmod:         snd_seq_kernel_client_enqueue
depmod:         snd_seq_kernel_client_dispatch
depmod:         snd_seq_kernel_client_ctl
depmod:         snd_midi_event_free
depmod:         snd_midi_event_encode_byte
depmod:         snd_oss_info_register
depmod:         snd_iprintf
depmod:         snd_seq_kernel_client_enqueue_blocking
depmod:         snd_midi_event_new
depmod:         snd_info_register
depmod:         snd_midi_event_no_status
depmod:         snd_seq_device_register_driver
depmod:         snd_unregister_oss_device
depmod:         snd_info_unregister
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/seq/snd-seq-device.ko
depmod:         snd_seq_root
depmod:         snd_kcalloc
depmod:         snd_info_create_module_entry
depmod:         snd_info_free_entry
depmod:         snd_device_new
depmod:         snd_iprintf
depmod:         snd_info_register
depmod:         snd_info_unregister
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/seq/snd-seq-dummy.ko
depmod:         snd_seq_delete_kernel_client
depmod:         snd_seq_create_kernel_client
depmod:         snd_kcalloc
depmod:         snd_seq_kernel_client_dispatch
depmod:         snd_seq_kernel_client_ctl
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/seq/snd-seq-midi-event.ko
depmod:         snd_kcalloc
depmod:         snd_seq_expand_var_event
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/seq/snd-seq-midi.ko
depmod:         snd_midi_event_decode
depmod:         snd_rawmidi_drain_output
depmod:         snd_seq_delete_kernel_client
depmod:         snd_seq_device_unregister_driver
depmod:         snd_seq_create_kernel_client
depmod:         snd_kcalloc
depmod:         snd_rawmidi_kernel_release
depmod:         snd_seq_kernel_client_dispatch
depmod:         snd_midi_event_reset_encode
depmod:         snd_seq_kernel_client_ctl
depmod:         snd_rawmidi_info_select
depmod:         snd_midi_event_free
depmod:         snd_rawmidi_kernel_read
depmod:         snd_rawmidi_output_params
depmod:         snd_seq_dump_var_event
depmod:         snd_rawmidi_kernel_open
depmod:         snd_midi_event_new
depmod:         snd_midi_event_encode
depmod:         snd_rawmidi_input_params
depmod:         snd_rawmidi_kernel_write
depmod:         snd_seq_device_register_driver
depmod:         snd_midi_event_reset_decode
depmod:         snd_seq_event_port_detach
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/seq/snd-seq.ko
depmod:         snd_request_card
depmod:         snd_ecards_limit
depmod:         snd_timer_close
depmod:         snd_register_device
depmod:         snd_timer_pause
depmod:         snd_seq_root
depmod:         snd_kcalloc
depmod:         snd_info_create_module_entry
depmod:         snd_timer_open
depmod:         snd_timer_resolution
depmod:         snd_info_free_entry
depmod:         snd_timer_start
depmod:         snd_seq_device_load_drivers
depmod:         snd_unregister_device
depmod:         snd_iprintf
depmod:         snd_timer_stop
depmod:         snd_info_register
depmod:         snd_info_unregister
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/snd-pcm.ko
depmod:         snd_timer_new
depmod:         snd_dma_free_reserved
depmod:         snd_free_pages
depmod:         snd_register_device
depmod:         snd_timer_notify
depmod:         snd_dma_alloc_pages
depmod:         snd_info_get_line
depmod:         snd_card_file_remove
depmod:         snd_kcalloc
depmod:         snd_info_create_module_entry
depmod:         snd_info_free_entry
depmod:         snd_card_file_add
depmod:         snd_info_create_card_entry
depmod:         snd_dma_set_reserved
depmod:         snd_device_new
depmod:         snd_power_wait
depmod:         snd_ctl_unregister_ioctl
depmod:         snd_unregister_device
depmod:         snd_iprintf
depmod:         snd_device_free
depmod:         snd_timer_interrupt
depmod:         snd_info_register
depmod:         snd_ctl_register_ioctl
depmod:         snd_device_register
depmod:         snd_major
depmod:         snd_dma_get_reserved
depmod:         snd_malloc_pages
depmod:         snd_info_get_str
depmod:         snd_info_unregister
depmod:         snd_dma_free_pages
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/snd-rawmidi.ko
depmod:         snd_register_device
depmod:         snd_seq_device_new
depmod:         snd_register_oss_device
depmod:         snd_card_file_remove
depmod:         snd_kcalloc
depmod:         snd_info_free_entry
depmod:         snd_card_file_add
depmod:         snd_info_create_card_entry
depmod:         snd_device_new
depmod:         snd_oss_info_register
depmod:         snd_ctl_unregister_ioctl
depmod:         snd_unregister_device
depmod:         snd_iprintf
depmod:         snd_device_free
depmod:         snd_info_register
depmod:         snd_ctl_register_ioctl
depmod:         snd_device_register
depmod:         snd_unregister_oss_device
depmod:         snd_info_unregister
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/snd-timer.ko
depmod:         snd_ecards_limit
depmod:         snd_register_device
depmod:         snd_kcalloc
depmod:         snd_info_create_module_entry
depmod:         snd_info_free_entry
depmod:         snd_device_new
depmod:         snd_oss_info_register
depmod:         snd_unregister_device
depmod:         snd_iprintf
depmod:         snd_info_register
depmod:         snd_kmalloc_strdup
depmod:         snd_info_unregister
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/core/snd.ko
depmod:         unregister_sound_special
depmod:         register_sound_special
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/drivers/snd-dummy.ko
depmod:         snd_pcm_new
depmod:         snd_free_pages
depmod:         snd_pcm_format_width
depmod:         snd_kcalloc
depmod:         snd_ctl_add
depmod:         snd_malloc_pages_fallback
depmod:         snd_pcm_period_elapsed
depmod:         snd_pcm_set_ops
depmod:         snd_pcm_lib_ioctl
depmod:         snd_card_register
depmod:         snd_ctl_new1
depmod:         snd_card_free
depmod:         snd_card_new
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/oss/dmasound/dmasound_core.ko
depmod:         unregister_sound_dsp
depmod:         register_sound_dsp
depmod:         register_sound_mixer
depmod:         unregister_sound_mixer
depmod:         unregister_sound_special
depmod:         register_sound_special
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/oss/dmasound/dmasound_pmac.ko
depmod:         i2c_detach_client
depmod:         i2c_smbus_write_word_data
depmod:         dmasound
depmod:         get_afmt_string
depmod:         i2c_del_driver
depmod:         dmasound_init
depmod:         dmasound_catchRadius
depmod:         dmasound_deinit
depmod:         i2c_smbus_write_block_data
depmod:         dmasound_read_sq
depmod:         i2c_smbus_write_byte_data
depmod:         i2c_attach_client
depmod:         i2c_add_driver
depmod:         dmasound_write_sq
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/ppc/snd-powermac.ko
depmod:         snd_pcm_new
depmod:         snd_ctl_notify
depmod:         i2c_detach_client
depmod:         snd_pcm_set_sync
depmod:         snd_pcm_lib_free_pages
depmod:         snd_kcalloc
depmod:         i2c_del_driver
depmod:         snd_ctl_add
depmod:         snd_device_new
depmod:         snd_pcm_lib_malloc_pages
depmod:         snd_pcm_period_elapsed
depmod:         i2c_smbus_write_block_data
depmod:         snd_pcm_suspend_all
depmod:         snd_pcm_lib_preallocate_free_for_all
depmod:         snd_pcm_set_ops
depmod:         snd_pcm_lib_ioctl
depmod:         snd_card_register
depmod:         i2c_smbus_write_byte_data
depmod:         snd_ctl_new1
depmod:         i2c_attach_client
depmod:         snd_card_free
depmod:         snd_pcm_lib_preallocate_pages_for_all
depmod:         i2c_add_driver
depmod:         snd_card_new
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test7/kernel/sound/usb/snd-usb-audio.ko
depmod:         snd_pcm_new
depmod:         snd_rawmidi_transmit_peek
depmod:         snd_rawmidi_transmit_ack
depmod:         snd_ctl_free_one
depmod:         snd_pcm_hw_rule_add
depmod:         snd_pcm_lib_free_pages
depmod:         snd_pcm_format_name
depmod:         snd_kcalloc
depmod:         snd_ctl_find_id
depmod:         snd_ctl_add
depmod:         snd_device_new
depmod:         snd_rawmidi_receive
depmod:         snd_pcm_lib_malloc_pages
depmod:         snd_rawmidi_new
depmod:         snd_pcm_period_elapsed
depmod:         snd_card_proc_new
depmod:         snd_pcm_lib_preallocate_pages
depmod:         snd_pcm_new_stream
depmod:         snd_rawmidi_set_ops
depmod:         snd_pcm_format_physical_width
depmod:         snd_pcm_hw_constraint_minmax
depmod:         snd_iprintf
depmod:         snd_pcm_lib_preallocate_free_for_all
depmod:         snd_pcm_set_ops
depmod:         snd_pcm_lib_ioctl
depmod:         snd_card_register
depmod:         snd_pcm_stop
depmod:         snd_ctl_new1
depmod:         snd_card_free_in_thread
depmod:         snd_card_free
depmod:         snd_card_new
depmod:         snd_card_disconnect



+--------------------------------------------------------------+
| Ken Offer                               Office: 512-835-3859 |
| Email: koffer@arlut.utexas.edu             Fax: 512-835-3259 |
| Applied Research Laboratories, University of Texas at Austin |
+--------------------------------------------------------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
