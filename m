Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE7E4DDE0E
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jun 2008 17:04:15 +1000 (EST)
Subject: Re: macmini g4 can't boot with new kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Young <hidave.darkstar@gmail.com>
In-Reply-To: <a8e1da0806142112v6969d22v45731a1ff821c5df@mail.gmail.com>
References: <a8e1da0806142112v6969d22v45731a1ff821c5df@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 15 Jun 2008 17:04:05 +1000
Message-Id: <1213513445.8129.91.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-06-15 at 12:12 +0800, Dave Young wrote:
> Hi,
> 
> I recently built kernel 2.6.26-rc5 for my macmini g4, but it can't
> boot. I'm not sure if it's related to kernel or yaboot, or the open
> firmware.
> 
> My distribution is yellowdog 6.1, config file attached
> 
> After load the kernel , it reports:
> 
> zImage starting : loaded at 0x004001f8 (SP:0x0023eea4)
> Allocating 0xc04b26c1 bytes
> ...
> Invalid memory access at %SRR0 : 004020e4 %SRR1 : 00003030

What are you trying to boot precisely ?

>From yaboot, I would suggest you try to boot a straight vmlinux rather
than a zImage. The later's never been really supported.

Cheers,
Ben.
