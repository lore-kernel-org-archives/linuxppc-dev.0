Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 4DA0F67D93
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 00:30:55 +1000 (EST)
Date: Fri, 29 Jul 2005 07:29:47 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Grab <d.grab@hima.com>
Message-ID: <20050729072947.A19366@cox.net>
References: <001f01c59417$fe81b840$f201a8c0@SN7606>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <001f01c59417$fe81b840$f201a8c0@SN7606>;
	from d.grab@hima.com on Fri, Jul 29, 2005 at 10:32:01AM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ATI Radeon with PPC 440 GX and kernel 2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jul 29, 2005 at 10:32:01AM +0200, David Grab wrote:
> Hello,
> 
> i´m using on my custom board a ATI M6 Mobility Radeon with kernel 2.6.12.
> Now i have to initialize the ati and configure the kernel to support it. Did
> someone use this combination (ppc + ati radeon)? It would be appreciating to
> get some help or tipps in configuring to get the ati functioning. Especially
> the BIOS of the ATI chip, because i have actually found only x86 binaries.
> Is it also possible to set up the bios settings for the ati chip without an
> bios eeprom attached via the radeon driver?

There is a x86 emulator that can execute x86 VGA BIOS code to initialize
your VGA core in U-Boot. It's part of the MAI port so you can look at
that code and port it to your board. It is actually some scitechsoft
code that's been ported to build within U-Boot.

Gabriel Paubert's preploader code also has an x86 real mode emulator
written in PPC assembly that does the same thing, but it may be more
convenient to work with the stuff in U-Boot. It doesn't help that I
can seem to find a current link to the preploader code. Maybe Gabriel
can appear and provide it.

-Matt
