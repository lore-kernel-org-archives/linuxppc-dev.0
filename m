Return-Path: <hbausley@deltatau.com>
Received: from Barracuda.deltatau.com (64-60-44-212.static-ip.telepacific.net
	[64.60.44.212]) by ozlabs.org (Postfix) with ESMTP id C9392DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 10:58:02 +1100 (EST)
Received: from mail.deltatau.com (localhost [127.0.0.1])
	by Barracuda.deltatau.com (Spam Firewall) with ESMTP id 1467525A1E
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 16:41:10 -0700 (PDT)
Received: from mail.deltatau.com (smtp.deltatau.com [64.60.44.211]) by
	Barracuda.deltatau.com with ESMTP id aS3lRD1NdctKsDWb for
	<linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 16:41:10 -0700 (PDT)
Message-ID: <04bf01c9b262$95478040$0109220a@deltatau.local>
From: "Henry Bausley" <hbausley@deltatau.com>
To: <linuxppc-dev@ozlabs.org>
References: <20090331125028.066613801@denx.de><20090331125451.600446749@denx.de><20090331133953.GB3044@pengutronix.de><49D21EF1.9050200@grandegger.com>
	<20090331135629.GC3044@pengutronix.de>
Subject: PowerPC 460EX AD7416 Temperature Sensor
Date: Tue, 31 Mar 2009 17:41:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does anyone know if the I2C temperature sensor is functioning on the AMCC 
460EX?
When I do a cat /proc/ad7416 I get the following crash.

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc02cbe28
Oops: Kernel access of bad area, sig: 11 [#1]
PowerPC 44x Platform
NIP: c02cbe28 LR: c023cec8 CTR: c023d314
REGS: ef107d90 TRAP: 0300   Not tainted  (2.6.28.7)
MSR: 00029000 <EE,ME>  CR: 88000444  XER: 00000000
DEAR: 00000000, ESR: 00000000
TASK = ef8590c0[2611] 'cat' THREAD: ef106000
GPR00: 00000000 ef107e40 ef8590c0 00000000 ef107e9c 00000000 00000c00 
ef107e98
GPR08: 00000000 c0330000 ffffffff c0330000 48000448 1001cb7c 100042bc 
100df49c
GPR16: 00000002 00000400 c032f014 c032efe4 ef107e9c ef107e98 bfffffff 
efb43a00
GPR24: ef61d000 00000000 ef107f20 ef107e98 00000c00 c0400000 00001000 
efb43a00
NIP [c02cbe28] mutex_lock+0x0/0x1c
LR [c023cec8] ad7416_read_temp+0x24/0x80
Call Trace:
[ef107e40] [00000400] 0x400 (unreliable)
[ef107e70] [c023d334] i2c_ad7416_read_proc+0x20/0x70
[ef107e90] [c00e8018] proc_file_read+0x108/0x334
[ef107ee0] [c00e2d3c] proc_reg_read+0x4c/0x70
[ef107ef0] [c00a54e8] vfs_read+0xb4/0x16c
[ef107f10] [c00a58e0] sys_read+0x4c/0x90
[ef107f40] [c000ea88] ret_from_syscall+0x0/0x3c
Instruction dump:
90010014 38000001 90030000 85230004 7f891800 419e000c 80690008 4bd50779
80010014 38210010 7c0803a6 4e800020 <7c001828> 3000ffff 7c00192d 40a2fff4
---[ end trace 774db769c3754abe ]---



**********************************************************
Outbound scan for Spam or Virus by Barracuda at Delta Tau
**********************************************************
