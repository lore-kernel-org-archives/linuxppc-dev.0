Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <002b01c32088$08c16900$50905943@LEIYINGDU>
From: "Leiying Du" <ldu@solectek.com>
To: "'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: unresolved symbol after doing make modules_install
Date: Thu, 22 May 2003 10:31:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using the ELDK202 and the kernel version is 2.4.4. The host platform is
RedHat 8.0. I did the follow procedures:

1) make dep
2) make all
3) make modules
4) make modules_install INSTALL_MOD_PATH=/home/eldk/rootfs

I have replaced the host depmod with the depmod.pl from busybox in the
Makefile. After I did step 4, I got the
following output:

I have checked the C code and everything looks Ok. Does anyone know why I
got those error messages? Thanks,


Leiying

make -C kernel modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/kernel'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/eldk/linux-2.4.4/kernel'
make -C drivers modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/drivers'
make -C block modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/block'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/block'
make -C cdrom modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/cdrom'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/cdrom'
make -C char modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/char'
make -C joystick modules_install
make[3]: Entering directory `/home/eldk/linux-2.4.4/drivers/char/joystick'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/home/eldk/linux-2.4.4/drivers/char/joystick'
make -C pcmcia modules_install
make[3]: Entering directory `/home/eldk/linux-2.4.4/drivers/char/pcmcia'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/home/eldk/linux-2.4.4/drivers/char/pcmcia'
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/char'
make -C input modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/input'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/input'
make -C media modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/media'
make -C radio modules_install
make[3]: Entering directory `/home/eldk/linux-2.4.4/drivers/media/radio'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/home/eldk/linux-2.4.4/drivers/media/radio'
make -C video modules_install
make[3]: Entering directory `/home/eldk/linux-2.4.4/drivers/media/video'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/home/eldk/linux-2.4.4/drivers/media/video'
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/media'
make -C misc modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/misc'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/misc'
make -C net modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/net'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/net'
make -C parport modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/parport'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/parport'
make -C sound modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/sound'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/sound'
make -C video modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/drivers/video'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/drivers/video'
make[1]: Leaving directory `/home/eldk/linux-2.4.4/drivers'
make -C mm modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/mm'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/eldk/linux-2.4.4/mm'
make -C fs modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/fs'
mkdir -p /home/eldk/rootfs/lib/modules/2.4.4/kernel/fs/
cp binfmt_misc.o /home/eldk/rootfs/lib/modules/2.4.4/kernel/fs/
make[1]: Leaving directory `/home/eldk/linux-2.4.4/fs'
make -C net modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/net'
make -C ipv4 modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/net/ipv4'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/net/ipv4'
make -C ipv4/netfilter modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/net/ipv4/netfilter'
mkdir -p /home/eldk/rootfs/lib/modules/2.4.4/kernel/net/ipv4/netfilter/
cp iptable_filter.o ipt_limit.o ipt_mark.o ipt_mac.o ipt_multiport.o
ipt_tos.o ipt_REJECT.o
/home/eldk/rootfs/lib/modules/2.4.4/kernel/net/ipv4/netfilter/
make[2]: Leaving directory `/home/eldk/linux-2.4.4/net/ipv4/netfilter'
make -C netlink modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/net/netlink'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/net/netlink'
make -C sched modules_install
make[2]: Entering directory `/home/eldk/linux-2.4.4/net/sched'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/eldk/linux-2.4.4/net/sched'
make[1]: Leaving directory `/home/eldk/linux-2.4.4/net'
make -C ipc modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/ipc'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/eldk/linux-2.4.4/ipc'
make -C lib modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/eldk/linux-2.4.4/lib'
make -C arch/ppc/kernel modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/arch/ppc/kernel'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/eldk/linux-2.4.4/arch/ppc/kernel'
make -C arch/ppc/mm modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/arch/ppc/mm'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/eldk/linux-2.4.4/arch/ppc/mm'
make -C arch/ppc/lib modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/arch/ppc/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/eldk/linux-2.4.4/arch/ppc/lib'
make -C arch/ppc/8xx_io modules_install
make[1]: Entering directory `/home/eldk/linux-2.4.4/arch/ppc/8xx_io'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/eldk/linux-2.4.4/arch/ppc/8xx_io'
cd /home/eldk/rootfs/lib/modules/2.4.4; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /home/eldk/scripts/depmod.pl -F System.map -k
vmlinux -b /home/eldk/rootfs/lib/modules/2.4.4; fi
unresolved symbol ipt_register_match_R65b8d3cd in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_limit.o
unresolved symbol ipt_unregister_match_R03a9ad03 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_limit.o
unresolved symbol irq_stat_Rb9459622 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_limit.o
unresolved symbol jiffies_R0da02d67 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_limit.o
unresolved symbol printk_Rdd132261 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_limit.o
unresolved symbol ipt_do_table_Rd8ad1b8a in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/iptable_filter.o
unresolved symbol ipt_register_table_R43a48119 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/iptable_filter.o
unresolved symbol ipt_unregister_table_Ra0a4368b in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/iptable_filter.o
unresolved symbol net_ratelimit_Rf6ebc03b in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/iptable_filter.o
unresolved symbol nf_register_hook_R83a237aa in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/iptable_filter.o
unresolved symbol nf_unregister_hook_Raff8f498 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/iptable_filter.o
unresolved symbol printk_Rdd132261 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/iptable_filter.o
unresolved symbol ipt_register_match_R65b8d3cd in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_multiport.o
unresolved symbol ipt_unregister_match_R03a9ad03 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_multiport.o
unresolved symbol add_timer_Ra19eacf8 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol __cli_Re45078fb in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol __copy_tofrom_user_Re410a3dd in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol create_proc_entry_Ra5b085aa in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol del_timer_Rfc62f16d in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol ether_setup_Rf03bfe7f in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol eth_type_trans_Rb957eb3b in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol get_random_bytes_R79aa04a2 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol interruptible_sleep_on_R0cccea81 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol irq_stat_Rb9459622 in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol jiffies_R0da02d67 in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol kfree_R037a0cba in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol __kfree_skb_R50509934 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol kmalloc_R93d4cfe6 in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol netif_rx_Rad8e5a54 in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol netlink_broadcast_R07fa8c60 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol netlink_kernel_create_R6514bdab in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol printk_Rdd132261 in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol proc_mkdir_R55c79205 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol proc_net_R4b8256aa in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol ___pskb_trim_Rd8e938b6 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol register_netdevice_Rc4e3e2dd in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol remove_proc_entry_R83c36c39 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol __restore_flags_R9a3562fe in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol rtnl_lock_Rc7a4fbed in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol rtnl_unlock_R6e720ff2 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol __save_flags_ptr_R98964d1e in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol skb_under_panic_R2c930c36 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol sock_release_Rf5e3554e in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol softnet_data_R599b4a24 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol sprintf_R3c2c5af5 in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol strcpy_Re914e41e in file /lib/modules/2.4.4/net/p80211.o
unresolved symbol tasklet_init_Ra5808bbf in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol tasklet_vec_R41d3b367 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol unregister_netdevice_Rc276c501 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol __wake_up_R2769b667 in file
/lib/modules/2.4.4/net/p80211.o
unresolved symbol add_timer_Ra19eacf8 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol add_wait_queue_R07ca739a in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol alloc_skb_R6e0accd1 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol CardServices_Re4eef0a4 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol __cli_Re45078fb in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol __delay_R850239f9 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol del_timer_Rfc62f16d in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol __down_interruptible_R9ef0b7cf in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol get_random_bytes_R79aa04a2 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol irq_stat_Rb9459622 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol jiffies_R0da02d67 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol kfree_R037a0cba in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol __kfree_skb_Rfa8ab6db in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol kmalloc_R93d4cfe6 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol loops_per_jiffy_Rba497f13 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol printk_Rdd132261 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol register_pccard_driver_R583d4ed2 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol remove_wait_queue_R694616fa in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol __restore_flags_R9a3562fe in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol __save_flags_ptr_R98964d1e in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol schedule_task_R2d6c3d04 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol schedule_timeout_Rd62c833f in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol skb_over_panic_R66acbbca in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol softnet_data_R6a71bc43 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol strcpy_Re914e41e in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol strlen_R97255bdf in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol unregister_pccard_driver_Rdb348cd2 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol __up_R7849bd7c in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol __wake_up_R2769b667 in file
/lib/modules/2.4.4/pcmcia/prism2_cs.o
unresolved symbol ipt_register_match_R65b8d3cd in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_tos.o
unresolved symbol ipt_unregister_match_R03a9ad03 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_tos.o
unresolved symbol copy_strings_kernel_Rdd7a2b67 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol create_proc_entry_Ra5b085aa in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol _ctype_R8d3894f2 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol fput_R5525cf0c in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol kfree_R037a0cba in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol kmalloc_R93d4cfe6 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol open_exec_Rdf2955aa in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol prepare_binprm_R95986000 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol printk_Rdd132261 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol proc_mkdir_R55c79205 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol register_binfmt_Rf1c6500e in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol remove_arg_zero_Ra60db3f5 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol remove_proc_entry_R83c36c39 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol search_binary_handler_R975f343c in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol sprintf_R3c2c5af5 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol strcmp_Re2d5255a in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol strlen_R97255bdf in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol strncpy_R328a05f1 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol strrchr_R9f984513 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol unregister_binfmt_R68c7ecc5 in file
/lib/modules/2.4.4/kernel/fs/binfmt_misc.o
unresolved symbol alloc_skb_Rd7e1aaa1 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol csum_partial_R94095c16 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol csum_tcpudp_magic_R12d43649 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ip_ct_attach_R7b09a6d8 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ip_fast_csum_Re4627d16 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ip_finish_output_R00bea65e in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ip_route_output_key_R104e9a1a in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol __ip_select_ident_R724a7149 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ipt_register_target_Rd20b759a in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ipt_unregister_target_R4d61c57e in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ipv4_config_R26b99782 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol __kfree_skb_R50509934 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol nf_hook_slow_R85fd0106 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol nf_hooks_R078b1fd2 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol printk_Rdd132261 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ___pskb_trim_Rd8e938b6 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol skb_copy_Re04b6073 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol skb_over_panic_R44f40cf1 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol strcmp_Re2d5255a in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol xrlim_allow_R4ee7f8d4 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_REJECT.o
unresolved symbol ipt_register_match_R65b8d3cd in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_mac.o
unresolved symbol ipt_unregister_match_R03a9ad03 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_mac.o
unresolved symbol printk_Rdd132261 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_mac.o
unresolved symbol ipt_register_match_R65b8d3cd in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_mark.o
unresolved symbol ipt_unregister_match_R03a9ad03 in file
/lib/modules/2.4.4/kernel/net/ipv4/netfilter/ipt_mark.o


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
