Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 26A0D2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 01:43:52 +1100 (EST)
In-Reply-To: <41E7A410.6060008@anagramm.de>
References: <41E7A410.6060008@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <B29E7784-663A-11D9-A3DB-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 14 Jan 2005 08:43:47 -0600
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6.x to MPC8540/Microsys Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[snip]
> My questions are now:
>  Which is the best Kernel source tree to start porting 2.6.x to the=20
> pm854
> platform? I would prefer to stuck with the official sources. Is that a
> good idea?

I would suggest 2.6.10 if you want an official kernel release.  Is this=20=

board generally available to people?  If so, and you want support for=20
this board in the official kernel, send me your patches for review. =20
I'll then push them up stream.

Be aware there are some infrastrucal changes I'm working on that moves=20=

the 85xx sub-arch support from using OCP to platform_device.  However,=20=

these have minor changes on the board files.

> Is it a good idea to just 'copy' the pm854 platform specific files =
(PCI
> =A0 initialization and some MTD driver options) to the 2.6.10 tree and=20=

> see
>  how it works?

I would take a look at how 2.6 is structured for 85xx.  I tried to do a=20=

better job and provide more common code for a board port to leverage. =20=

So for something like PCI, you should hopefully just have to setup your=20=

memory map and IRQ routing.

> As there anybody who has already a working 2.6.10-something for =
MPC8540
> (well, non mpc8540ads).

I'm not aware of anyone else with another MPC8540 port, I know of other=20=

MPC8560's, and MPC8555/41 ports.

- kumar
