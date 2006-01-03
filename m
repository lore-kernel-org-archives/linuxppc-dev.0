Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8F71C6898B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jan 2006 20:54:32 +1100 (EST)
Date: Tue, 3 Jan 2006 10:54:26 +0100
From: Olaf Hering <olh@suse.de>
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20060103095426.GA19336@suse.de>
References: <20051228224937.GA6320@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051228224937.GA6320@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: mv643xx_eth,
	sleeping function called from invalid context at mm/slab.c:2472
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Dec 28, Dale Farnsworth wrote:

> (For unknown reasons, I didn't receive this message directly from the
> mailing list, and the archive doesn't seem to have message-ids, so
> I can't supply a References: header.)

This doesnt help:

MV-643xx 10/100/1000 Ethernet Driver
eth1: port 1 with MAC address 00:2b:2f:de:ad:01
eth1: Scatter Gather Enabled
eth1: TX TCP/IP Checksumming Supported
eth1: RX TCP/UDP Checksum Offload ON
eth1: RX NAPI Enabled
eth1: Using SRAM
Debug: sleeping function called from invalid context at mm/slab.c:2472
in_atomic():0, irqs_disabled():1
Call Trace:
[C3E01D40] [C000BCAC] show_stack+0x54/0x184 (unreliable)
[C3E01D60] [C0028E68] __might_sleep+0xbc/0xd0
[C3E01D70] [C005FD3C] __kmalloc+0x88/0x158
[C3E01D90] [D2281264] mv643xx_eth_real_open+0x15c/0x4b4 [mv643xx_eth]
[C3E01DC0] [D22820C0] mv643xx_eth_open+0x68/0xb0 [mv643xx_eth]
[C3E01DE0] [C025638C] dev_open+0x70/0xd8
[C3E01E00] [C02544F8] dev_change_flags+0x6c/0x13c
[C3E01E20] [C02A1838] devinet_ioctl+0x280/0x708
[C3E01E80] [C02A21BC] inet_ioctl+0xb4/0x100
[C3E01E90] [C02BF1A0] packet_ioctl+0x15c/0x188
[C3E01EB0] [C024A9A8] sock_ioctl+0x30c/0x334
[C3E01ED0] [C0093350] do_ioctl+0x3c/0x88
[C3E01EE0] [C0093784] vfs_ioctl+0x3e8/0x424
[C3E01F10] [C0093828] sys_ioctl+0x68/0x98
[C3E01F40] [C0010A60] ret_from_syscall+0x0/0x4c
--- Exception: c01 at 0x7f666e8
    LR = 0x7f66680
eth1: no IPv6 routers present



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
