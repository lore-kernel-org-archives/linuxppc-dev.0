Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 196A0DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:03:12 +1000 (EST)
Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Dave Liu <r63238@freescale.com>
In-Reply-To: <1181788277.3658.1.camel@localhost.localdomain>
References: <1181744529.30670.298.camel@gentoo-jocke.transmode.se>
	<1181788277.3658.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 09:03:08 +0200
Message-Id: <1181804588.30670.344.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-14 at 10:31 +0800, Dave Liu wrote:
> On Wed, 2007-06-13 at 16:22 +0200, Joakim Tjernlund wrote:
> > Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
> > a Freescale 832x CPU gives me this:
> >  ifconfig eth2 up
> >  ucc_geth_startup: Can not allocate DPRAM memory for p_thread_data_tx.
> >  eth2: Cannot configure net device, aborting.
> >  SIOCSIFFLAGS: Cannot allocate memory
> > 
> > This worked in 2.6.20
> 
> Could you print the MURAM memory usage for debug?
> eg. start address and size.
> 
> -d

Like this?
eth1:
MURAM alloc, start:1400, size:512, align:8
MURAM alloc, start:1608, size:520, align:8
MURAM alloc, start:1880, size:128, align:128
MURAM alloc, start:1a00, size:416, align:256
MURAM alloc, start:1bc0, size:64, align:32
MURAM alloc, start:1d00, size:256, align:256
MURAM alloc, start:1f00, size:160, align:256
MURAM alloc, start:1fc0, size:12, align:64
MURAM alloc, start:2000, size:48, align:8
MURAM alloc, start:2080, size:128, align:128
MURAM alloc, start:2180, size:128, align:128
MURAM alloc, start:2280, size:128, align:128
MURAM alloc, start:2380, size:128, align:128
MURAM alloc, start:2440, size:64, align:64
MURAM alloc, start:24c0, size:64, align:64
MURAM alloc, start:2540, size:64, align:64
MURAM alloc, start:25c0, size:64, align:64
MURAM alloc, start:262c, size:93, align:4

eth0:
MURAM alloc, start:2630, size:512, align:8
MURAM alloc, start:2838, size:520, align:8
MURAM alloc, start:2a80, size:128, align:128
MURAM alloc, start:2c00, size:416, align:256
MURAM alloc, start:2de0, size:64, align:32
MURAM alloc, start:2f00, size:256, align:256
MURAM alloc, start:3100, size:160, align:256
MURAM alloc, start:3200, size:12, align:64
MURAM alloc, start:3228, size:48, align:8
MURAM alloc, start:3280, size:128, align:128
MURAM alloc, start:3380, size:128, align:128
MURAM alloc, start:3480, size:128, align:128
MURAM alloc, start:3580, size:128, align:128
MURAM alloc, start:3680, size:64, align:64
MURAM alloc, start:3700, size:64, align:64
MURAM alloc, start:3780, size:64, align:64
MURAM alloc, start:3800, size:64, align:64
MURAM alloc, start:3858, size:93, align:4

eth2:
MURAM alloc, start:3858, size:512, align:8
MURAM alloc, start:3a60, size:520, align:8
MURAM alloc, start:3c80, size:128, align:128
MURAM alloc, start:fffffff4, size:416, align:256

Jocke
