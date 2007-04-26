Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD961DDF5A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 04:58:24 +1000 (EST)
In-Reply-To: <4630E0F3.10100@anagramm.de>
References: <4630E0F3.10100@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4154057F-C9C4-43AE-B539-182198EA04CF@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: BUG: NETDEV WATCHDOG -> Badness in gianfar driver?
Date: Thu, 26 Apr 2007 13:58:24 -0500
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 26, 2007, at 12:27, Clemens Koller wrote:

> Hi There!

>
> Any ideas of what could be wrong there? I think there could be a  
> problem
> in the gianfar network driver. Or is there a physical problem with  
> the PHY
> (a Marvell MV88E1111)?

hard to say which.
> Jan  1 03:43:23 ecam kernel: ------------[ cut here ]------------
> Jan  1 03:43:23 ecam kernel: Badness at c003d3d8 [verbose debug  
> info unavailable]
> Jan  1 03:43:23 ecam kernel: Call Trace:
> Jan  1 03:43:23 ecam kernel: [C0355C70] [C0008FE0] show_stack+0x3c/ 
> 0x194 (unreliable)
> Jan  1 03:43:23 ecam kernel: [C0355CA0] [C0135594] report_bug 
> +0xa4/0xac
> Jan  1 03:43:23 ecam kernel: [C0355CB0] [C0003784]  
> program_check_exception+0x2b8/0x460
> Jan  1 03:43:23 ecam kernel: [C0355CD0] [C0002908]  
> ret_from_except_full+0x0/0x4c
> Jan  1 03:43:23 ecam kernel: [C0355D90] [C017B3CC]  
> marvell_ack_interrupt+0x14/0x38
> Jan  1 03:43:23 ecam kernel: [C0355DB0] [C01764A8] stop_gfar+0x54/0xd0
> Jan  1 03:43:23 ecam kernel: [C0355DD0] [C01773D0] gfar_timeout 
> +0x5c/0x68


This is a bit confusing.  Could you identify where in  
marvell_ack_interrupt this is?

Andy
