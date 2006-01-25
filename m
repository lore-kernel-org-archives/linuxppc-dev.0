Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A63B568A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 03:10:11 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0PGA3xo022830
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Jan 2006 17:10:03 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
Subject: Re: Trouble with SMC serial port in ppc/boot/simple on Embedded
	Planet8248 board
Date: Wed, 25 Jan 2006 17:09:56 +0100
References: <1628E43D99629C46988BE46087A3FBB942B7F8@ep-01.EmbeddedPlanet.local>
In-Reply-To: <1628E43D99629C46988BE46087A3FBB942B7F8@ep-01.EmbeddedPlanet.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601251709.56877.laurent.pinchart@tbox.biz>
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

> > I'm trying to port the Linux kernel (2.6.15.1) to the
> > Embedded Planet 8248 board. The board has a proprietary boot
> > loader and uses SMC1 has a serial console.
>
> Do you have SCC1 enabled also?  In arch/ppc/boot/simple/m8260_tty.c you
> will see that if SCC1 is enabled the early text tries to print to it,
> even if SMC1 is selected as the console in the config.  That was about
> the only trick to do to get the early text.

I commented that line to fix the problem, and I was thinking about either a 
configuration option (CONFIG_SERIAL_CONSOLE_SCCx and 
CONFIG_SERIAL_CONSOLE_SMCx) or a macro in the platform-specifix header file 
to override that. Any comment ?

Laurent Pinchart
