Return-Path: <mneuling@au1.ibm.com>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id A688EDDFAE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 17:24:14 +1100 (EST)
From: Michael Neuling <mneuling@au1.ibm.com>
To: Elbert C Hu <elbert@us.ibm.com>
Subject: Re: ehea: Error in ehea_treat_poll_error: CQE Error for QP 16 
In-reply-to: <OFE363B4D3.74531A27-ON852574DA.0057EAB7-852574DA.00581D46@us.ibm.com>
References: <OFE363B4D3.74531A27-ON852574DA.0057EAB7-852574DA.00581D46@us.ibm.com>
Date: Wed, 08 Oct 2008 16:24:13 +1000
Message-ID: <26463.1223447053@neuling.org>
Cc: Thomas Klein <tklein@de.ibm.com>, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Elbert,

Just CCing in the ehea maintainers...

Jan-Bernd, Thomas, Christoph: can you help with this query?

Mikey
--------
System log shows a lot of "ehea: Error", see below, during system start up.
Not sure what it is. I'd like to understand this, could someone points me the
direction? My "Machine Type and Model ... ST9146802SS" reported from lscfg (p6
blade). OS is RHEL 5.2. Kernel level is 2.6.18-92.1.10.el5.

Thanks.

E. Hu
************ ehea.modinfo ************
filename: /lib/modules/2.6.18-92.1.10.el5/kernel/drivers/net/ehea/ehea.ko
version: EHEA_0076-05
description: IBM eServer HEA Driver
author: Christoph Raisch <raisch@de.ibm.com>
license: GPL
srcversion: C481DB79B4694F406CF4AA7
depends:
vermagic: 2.6.18-92.1.10.el5 SMP mod_unload gcc-4.1
parm: num_tx_qps:Number of TX-QPS (int)
parm: msg_level:msg_level (int)
parm: prop_carrier_state:Propagate carrier state of physical port to stack.
1:yes, 0:no. Default = 0 (int)
parm: rq3_entries:Number of entries for Receive Queue 3 [2^x - 1], x =
[6..14]. Default = 1023) (int)
parm: rq2_entries:Number of entries for Receive Queue 2 [2^x - 1], x =
[6..14]. Default = 1023) (int)
parm: rq1_entries:Number of entries for Receive Queue 1 [2^x - 1], x =
[6..14]. Default = 4095) (int)
parm: sq_entries: Number of entries for the Send Queue [2^x - 1], x = [6..14].
Default = 1023) (int)
parm: use_mcs: 0:NAPI, 1:Multiple receive queues, Default = 0 (int)
parm: lro_max_aggr: LRO: Max packets to be aggregated. Default = 64 (int)
parm: use_lro: Large Receive Offload, 1: enable, 0: disable, Default = 0 (int)
module_sig:
883f3504886ebc8736cb7d2578e3b1112b7ab09e3b2c69b141d16d1bbbd51ab063f7955335a49e80a0ba218c849673e067f7c0ccc9d7353cc1ce05997

************ system log ************
Sep 29 09:35:35 newhamburg kernel: ehea: Error in ehea_treat_poll_error: CQE
Error for QP 16
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=c0000001ddbc1400 ofs=0000
0000000000000000 200040000000008e
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=c0000001ddbc1410 ofs=0010
0000d6ec002a0000 0400000000000000
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=c0000001ddbc1420 ofs=0020
0000000000000000 0000000000000000
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=c0000001ddbc1430 ofs=0030
0000000000000000 0000000000000000
Sep 29 09:40:10 newhamburg kernel: ehea: Error in ehea_treat_poll_error: CQE
Error for QP 16
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=c0000001dd9d2800 ofs=0000
0000000000000000 200040000000008e
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=c0000001dd9d2810 ofs=0010
0000d6ec002a0000 0800000000000000
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=c0000001dd9d2820 ofs=0020
0000000000000000 0000000000000000
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=c0000001dd9d2830 ofs=0030
0000000000000000 0000000000000000
Sep 29 10:08:17 newhamburg kernel: ehea: Error in ehea_treat_poll_error: CQE
Error for QP 16
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=c0000001dd9eb600 ofs=0000
0000000000000000 200040000000008e
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=c0000001dd9eb610 ofs=0010
0000d6ec002a0000 0600000000000000
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=c0000001dd9eb620 ofs=0020
0000000000000000 0000000000000000
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=c0000001dd9eb630 ofs=0030
0000000000000000 0000000000000000
Sep 29 10:21:51 newhamburg kernel: ehea: Error in ehea_treat_poll_error: CQE
Error for QP 16
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=c0000001dd9e2300 ofs=0000
0000000000000000 200040000000008e
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=c0000001dd9e2310 ofs=0010
0000d6ec002a0000 0300000000000000
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=c0000001dd9e2320 ofs=0020
0000000000000000 0000000000000000
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=c0000001dd9e2330 ofs=0030
0000000000000000 0000000000000000
Sep 29 16:16:23 newhamburg kernel: ehea: Error in ehea_treat_poll_error: CQE
Error for QP 16
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=c0000001ddb9a800 ofs=0000
0000030002630000 40804000000000e0
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=c0000001ddb9a810 ofs=0010
0000e10f002a0000 0800000000000000
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=c0000001ddb9a820 ofs=0020
0000000000000000 0000000000000000
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=c0000001ddb9a830 ofs=0030
0000000000000000 0000000000000000
Sep 29 21:50:04 newhamburg kernel: ehea: Error in ehea_treat_poll_error: CQE
Error for QP 16
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=c0000001dd9c0700 ofs=0000
0000000000000000 2080400000000076
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=c0000001dd9c0710 ofs=0010
0000fb42002a0000 0700000000000000
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=c0000001dd9c0720 ofs=0020
0000000000000000 0000000000000000
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=c0000001dd9c0730 ofs=0030
0000000000000000 0000000000000000
Sep 30 03:55:49 newhamburg kernel: ehea: Error in ehea_treat_poll_error: CQE
Error for QP 16
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=c0000001ddb4f900 ofs=0000
0000000000000000 2000400000000076
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=c0000001ddb4f910 ofs=0010
0000fb42002a0000 0900000000000000
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=c0000001ddb4f920 ofs=0020
0000000000000000 0000000000000000
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=c0000001ddb4f930 ofs=0030
0000000000000000 0000000000000000
Sep 30 09:12:02 newhamburg kernel: ehea: Error in ehea_treat_poll_error: CQE
Error for QP 16
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=c0000001ddbd6400 ofs=0000
0000000000000000 208040000000008e
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=c0000001ddbd6410 ofs=0010
0000d6ec002a0000 0400000000000000
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=c0000001ddbd6420 ofs=0020
0000000000000000 0000000000000000
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=c0000001ddbd6430 ofs=0030
0000000000000000 0000000000000000

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
