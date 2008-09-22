Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 36E48DDF27
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 01:13:09 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29]
	helo=jupiter.intranet.kreuzholzen.de)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1Khn5u-0005b7-TE
	for linuxppc-dev@ozlabs.org; Mon, 22 Sep 2008 17:13:02 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Mon, 22 Sep 2008 17:12:56 +0200
References: <200809221556.34353.jbe@pengutronix.de>
In-Reply-To: <200809221556.34353.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809221712.57487.jbe@pengutronix.de>
Subject: Re: MPC5200 PCI interrupt routing
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Montag, 22. September 2008, Juergen Beisert wrote:
> $ lspci
> 00:18.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 61) 00:18.1 USB Controller: VIA Technologies, Inc.
> VT82xxxxx UHCI USB 1.1 Controller (rev 61) 00:18.2 USB Controller: VIA
> Technologies, Inc. USB 2.0 (rev 63)
>
> USB driver (endianess???) or oftee or hardware problem?

Seems more a kernel problem. With a 2.6.23.1 at least MPC5200's internal OH=
CI=20
still works (EHCI and UHCI unchecked yet). With a 2.6.26.3 also this OHCI=20
fails.

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
