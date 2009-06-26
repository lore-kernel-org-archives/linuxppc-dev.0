Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 28BB8B707E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 02:56:04 +1000 (EST)
Message-ID: <4A44FD90.2040607@freescale.com>
Date: Fri, 26 Jun 2009 11:55:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
In-Reply-To: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mikhail Zaturenskiy wrote:
> Hello,
> 
> I'm trying to load Linux from U-Boot. I am using ELDK 4.2 with U-Boot
> 2009.03 on an EP88xC rev1.1 board (MPC885 cpu, 64MB RAM, 32MB FLASH).
> The linux kernel sources were obtained from instructions at
> "http://www.denx.de/wiki/view/DULG/LinuxConfiguration#Section_6.1."
> and the FDT blob (dtb) was generated from
> "linux-2.6-denx/arch/powerpc/boot/dts/ep88xc.dts". Below is my output
> from boot to hang:

This isn't the denx list; what kernel version is that, and with what 
modifications from mainline?

Note that ep88xc.dts in mainline is intended for use with PlanetCore, which is 
what ships on that board.  You may need to make modifications for it to work 
with u-boot (at the least, the IMMR base is probably different).  This is why 
u-boot should be maintaining its own repository of trees that it passes...

Also, make sure u-boot is properly updating the memory size in the device tree. 
  Can you dump the post-fixup device tree in u-boot?

-Scott
