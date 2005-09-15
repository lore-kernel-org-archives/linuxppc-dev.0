Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 6044268292
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 02:25:58 +1000 (EST)
Date: Thu, 15 Sep 2005 09:25:55 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
Message-ID: <20050915092555.A27452@cox.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<431260BA.7000107@jonmasters.org>
	<20050830083859.B5925@cox.net> <200509151803.15301.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200509151803.15301.sr@denx.de>;
	from sr@denx.de on Thu, Sep 15, 2005 at 06:03:14PM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC4xx cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 15, 2005 at 06:03:14PM +0200, Stefan Roese wrote:
> Hi,
> 
> I am right now testing and cleaning up some of the AMCC 4xx eval board ports 
> to better support U-Boot as firmware. One question before I begin to send a 
> few patches:
> 
> All of the 44x boards I looked at (e.g. Ocotea) have to be extended in the 
> platform file (e.g. platforms/4xx/ocotea.c) to not only copy the bd_info 
> struct from r3, but also check r4 and r6 for initrd and kernel command line 
> passing from the bootloader. Instead of adding this code to all different 
> platform files, I would like to move this code to the common function 
> "ibm44x_platform_init" (syslib/ibm44x_common.c) like it is done in the 40x 
> ports "ppc4xx_init" (syslib/ppc4xx_setup.c). 
> 
> Any objections/remarks?

Sounds great to me. This will have to wait to go in mainline until
after 2.6.14 is out though.

-Matt
