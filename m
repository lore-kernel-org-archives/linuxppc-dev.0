Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.co.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id BAFB167A81
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 21:01:56 +1000 (EST)
Message-ID: <42511E89.9010704@jonmasters.org>
Date: Mon, 04 Apr 2005 12:01:29 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
References: <424ACFF1.5000403@bitsim.se>	
	<111d2ae873d1bfee413409dfc4f2f064@freescale.com>	
	<424BEDFC.8080300@jonmasters.org>
	<1112284541.23088.77.camel@cashmere.sps.mot.com>
	<4250EACF.1040403@bitsim.se> <42511D55.4040507@ru.mvista.com>
In-Reply-To: <42511D55.4040507@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>, Jakob Viketoft <jakob.viketoft@bitsim.se>
Subject: Re: Flat OF Device Tree for ppc32 [was: Platform bus/ppc sys
	model...]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:

> Should we rely on U-Boot to give that device tree structure to
> the kernel?

I think this is the best way to do it - there's already a ppc_md struct 
kicking around which is semi-meant for this kind of thing.

> If I got it correct this is how the Freescale team plans to proceed.

Good. It might actually happen if enough of us want it to :-)

> Jon (Masters), are you going the same way?

Yes, but I'm more than willing to pitch in with the Freescale guys if 
that'll get things done faster - they've obviously got more manpower. I 
wanted to get this thing done already! :-)

> Anyone using arch/ppc/boot/simple bootwrapper with his Virtex 2 Pro
> board? If we drop Virtex 2 Pro support in arch/ppc/boot and move to
> U-Boot would it hurt anyone?

I don't use it. I have a very simple bootloader which I use on our Memec 
based design - comes in straight off sysace and jumps at the kernel 
after doing simple diagnostics, avoided the need for porting an existing 
boot loader and it's reasonably able to cope with braindead Xilinx HALs.

Jon.
