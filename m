Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69C86DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 00:55:59 +1100 (EST)
Message-Id: <7669531C-28D6-496E-8351-A4A8B02DF51C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: oops w/genphy & gianfar.. on MPC8315 RDB
Date: Tue, 17 Mar 2009 08:55:49 -0500
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy,

Any ideas what's going on here?  I'm trying to use top of Linus + PPC  
next.  Top of Linus doesn't show this.

- k

Setting up networking on eth0:
------------[ cut here ]------------
Kernel BUG at c0192e48 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
MPC831x RDB
Modules linked in:
NIP: c0192e48 LR: c01936a8 CTR: c0194870
REGS: c4c9dc90 TRAP: 0700   Not tainted  (2.6.29-rc8-00280-g242497a)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 84008228  XER: 00000000
TASK = c7469bd0[874] 'ifconfig' THREAD: c4c9c000
GPR00: 00000001 c4c9dd40 c7469bd0 c7462000 00000100 0000000f ffffffff  
00000000
GPR08: 00000220 00000000 fffee0bf 00000100 84002228 100237d4 07ff9000  
00000000
GPR16: 00000000 07fedc44 07fedc44 07fedc44 c7462000 ffff8914 c74603a0  
c74603ac
GPR24: c74621e8 c78c0e20 c9018000 c7462000 c7462000 c7462360 c6e3f800  
c7462360
NIP [c0192e48] startup_gfar+0x54/0x644
LR [c01936a8] gfar_enet_open+0x270/0x478
Call Trace:
[c4c9dd40] [c019be04] genphy_config_init+0xa4/0xc8 (unreliable)
[c4c9dd80] [c01936a8] gfar_enet_open+0x270/0x478
[c4c9ddb0] [c02238e8] dev_open+0xc0/0x124
[c4c9ddd0] [c0223048] dev_change_flags+0x90/0x1d4
[c4c9ddf0] [c0266a68] devinet_ioctl+0x700/0x7ac
[c4c9de60] [c0267b3c] inet_ioctl+0xcc/0xf8
[c4c9de70] [c0211afc] sock_ioctl+0x60/0x2c8
[c4c9de90] [c0099418] vfs_ioctl+0x34/0x90
[c4c9dea0] [c0099524] do_vfs_ioctl+0x8c/0x704
[c4c9df10] [c0099bdc] sys_ioctl+0x40/0x88
[c4c9df40] [c001167c] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff69268
     LR = 0xffecdec
Instruction dump:
90010008 835d007c 7c0004ac 901a0014 3b0301e8 817d001c 2e180000 809d0068
4192052c 812302bc 7d200034 5400d97e <0f000000> 81290000 7c845a14  
7f03c378
---[ end trace fca8f422a0a9a061 ]---
Trace/breakpoint trap
