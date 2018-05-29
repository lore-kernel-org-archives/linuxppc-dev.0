Return-Path: <srs0=exq5=iq=linux.vnet.ibm.com=vrbagal1@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40w9By65tjzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 20:36:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40w9By5YG7z8tGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 20:36:58 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40w9By0xWmz9rxs
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 20:36:57 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4TAXxD4098134
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 06:36:55 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j94yvgqx0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 06:36:54 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <vrbagal1@linux.vnet.ibm.com>;
 Tue, 29 May 2018 06:36:54 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4TAapGK1507676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 10:36:51 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6A08112064
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 06:36:53 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE264112063
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 06:36:53 -0400 (EDT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 06:36:53 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 29 May 2018 16:10:44 +0530
From: vrbagal1 <vrbagal1@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Kernel OOPS while running memory hotplug test on P6 machine
Message-Id: <1b135ed0b45b12dddbb722d6b433e97e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greetings!!!


I am observing kernel oops while running memory hotplug test on P6 
machine, on main line kernel.

Machine: Power 6
kernel version  4.17.0-rc6
gcc version 4.8.3 20140911 (Red Hat 4.8.3-7)

Trace:

10:36:09 Unable to handle kernel paging request for data at address 
0xc000492746462a90
10:36:09 Faulting instruction address: 0xc00000000023d190
10:36:09 Oops: Kernel access of bad area, sig: 11 [#1]
10:36:09 BE SMP NR_CPUS=1024 NUMA pSeries
10:36:09 Dumping ftrace buffer:
10:36:09    (ftrace buffer empty)
10:36:09 Modules linked in: rpadlpar_io(E) rpaphp(E) 
nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) ip6t_REJECT(E) 
nf_reject_ipv6(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ipt_REJECT(E) 
nf_reject_ipv4(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) cfg80211(E) 
xt_conntrack(E) nf_conntrack(E) rfkill(E) libcrc32c(E) ebtable_nat(E) 
ebtable_broute(E) bridge(E) stp(E) llc(E) ebtable_filter(E) ebtables(E) 
ip6table_mangle(E) ip6table_security(E) ip6table_raw(E) 
ip6table_filter(E) ip6_tables(E) iptable_mangle(E) iptable_security(E) 
iptable_raw(E) iptable_filter(E) ip_tables(E) ses(E) enclosure(E) 
osst(E) st(E) scsi_transport_sas(E) uio_pdrv_genirq(E) uio(E) ehea(E) 
nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) sunrpc(E) grace(E) ipv6(E) 
crc_ccitt(E) autofs4(E) ext4(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E)
10:36:09  sd_mod(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E) 
dax(E)
10:36:09 CPU: 2 PID: 7370 Comm: avocado Tainted: G            E     
4.17.0-rc6-autotest #1
10:36:09 NIP:  c00000000023d190 LR: c0000000002cb88c CTR: 
c0000000001259e0
10:36:09 REGS: c0000000fb0b7370 TRAP: 0300   Tainted: G            E     
  (4.17.0-rc6-autotest)
10:36:09 MSR:  800000000200b032 <SF,VEC,EE,FP,ME,IR,DR,RI>  CR: 24242488 
  XER: 00000000
10:36:09 CFAR: c000000000008924 DAR: c000492746462a90 DSISR: 40000000 
SOFTE: 1
10:36:09 GPR00: c0000000002cb630 c0000000fb0b75f0 c000000001126400 
c0000000d3333800
10:36:09 GPR04: 9249249249210100 0000000000000002 0000000000000007 
0000000000057800
10:36:09 GPR08: 0000492492492490 c0000002b3fd0600 0092492492492101 
0000000000000040
10:36:09 GPR12: 0000000024242488 c00000000eead000 00007fff95b31710 
00000080dee637a8
10:36:09 GPR16: 0000000000000000 c0000000d3fd6920 0000000000000001 
0000000000000001
10:36:09 GPR20: 0000000000000001 0000000000000000 000000000000cc00 
00000000003fffff
10:36:09 GPR24: c00000000116cab0 0000000000000008 0000000000000000 
0000000000000001
10:36:09 GPR28: c0000000012d1aa0 c0000000d3fd6920 c0000000d3fd6500 
c0000000d3330000
10:36:09 NIP [c00000000023d190] .get_pfnblock_flags_mask+0x20/0xd0
10:36:09 LR [c0000000002cb88c] .unset_migratetype_isolate+0x2bc/0x340
10:36:09 Call Trace:
10:36:09 [c0000000fb0b75f0] [c0000000002cb630] 
.unset_migratetype_isolate+0x60/0x340 (unreliable)
10:36:09 [c0000000fb0b76a0] [c0000000002cbc00] 
.start_isolate_page_range+0x2f0/0x4c0
10:36:09 [c0000000fb0b77a0] [c0000000002c5a74] 
.__offline_pages+0x114/0xaa0
10:36:09 [c0000000fb0b78f0] [c0000000005966d8] 
.memory_subsys_offline+0x58/0xe0
10:36:09 [c0000000fb0b7970] [c000000000572ba8] 
.device_offline+0xe8/0x130
10:36:09 [c0000000fb0b7a00] [c00000000059642c] 
.store_mem_state+0x15c/0x180
10:36:09 [c0000000fb0b7a90] [c00000000056dc10] .dev_attr_store+0x30/0x60
10:36:09 [c0000000fb0b7b00] [c00000000037fd70] .sysfs_kf_write+0x60/0xa0
10:36:09 [c0000000fb0b7b70] [c00000000037eb40] 
.kernfs_fop_write+0x180/0x250
10:36:09 [c0000000fb0b7c10] [c0000000002d2a4c] .__vfs_write+0x3c/0x1e0
10:36:09 [c0000000fb0b7cf0] [c0000000002d2e00] .vfs_write+0xc0/0x230
10:36:09 [c0000000fb0b7d90] [c0000000002d3124] .ksys_write+0x54/0x100
10:36:09 [c0000000fb0b7e30] [c00000000000b9d8] system_call+0x58/0x6c
10:36:09 Instruction dump:
10:36:09 4e800020 60000000 60000000 60000000 3d02001b 788ac202 3928b6a0 
e9290000
10:36:09 2fa90000 419e006c 78886502 79081f24 <7d29402a> 2fa90000 
419e000c 794a2428
10:36:09 ---[ end trace a4b1e0a92ed26a33 ]---


regards,
Venkat.
