Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id EFBCF679F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Jun 2005 02:08:52 +1000 (EST)
In-Reply-To: <429C8AC4.9000801@anagramm.de>
References: <429C8AC4.9000801@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bb83727d8d949477f261e00351c091f2@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 31 May 2005 11:08:47 -0500
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Complete ccsr map for mpc8540 available?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 31, 2005, at 11:03 AM, Clemens Koller wrote:

> Hello, Kumar!
>
> Yes, I want to add another Local Bus Address Range for our FPGA on
> an extra CS line. I've tried to do that in U-Boot as the Code is 
> already there.
> But my modified (some old 1.1.2 (not the official release) version) 
> U-Boot
> didn't work (I guess compiling issues) and rendered my Board 
> non-bootable, which
> was really no fun!
> I also want to play around with the bus-timing and GPCM/UPM 
> configurations.
> So, changing U-Boot for every little waitstate and re-booting just to 
> get
> a register changed is a showstopper for me. (Yes, I know, a BDI2000 
> would be fun).
> So I decided to do all my stuff first in linux in a module to shorten 
> the design
> cycle by a factor of 1E+3 which works fine now, as I started this 
> immr_t thingy
> for mpc8540 on my own...
>
> Now it seems that u-boot's immap_85xx.h is pretty much what I was 
> looking
> for, I will try to merge my stuff with it and get a immap_8540.h out 
> of it.
> So, you answered my question indirectly (get back to mainline) that 
> there
> is no code available on the linux side yet, right?

Yes, that was my thinking.  You can grab just the lbc bits and put them 
in immap_85xx.h and do the same ioremap thing we do for pci in 
arch/ppc/syslib/ppc85xx_setup.c.

> I can release my stuff, if anybody is interested... no problem.
> The LBC part is verified (some others are dummys and untested) and in
> a /works for me/ state.

It sounds like this is custom to your board so I wouldn't bother 
releasing it out unless it something you want to get into the standard 
kernel tree.

- kumar
