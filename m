Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 26E38DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 21:34:49 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Tue, 23 Sep 2008 13:34:17 +0200
References: <200809221556.34353.jbe@pengutronix.de>
	<48D807C5.4070002@genesi-usa.com>
In-Reply-To: <48D807C5.4070002@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200809231334.19175.jbe@pengutronix.de>
Subject: Re: MPC5200 PCI interrupt routing
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt,

On Montag, 22. September 2008, Matt Sealey wrote:
> Juergen Beisert wrote:
> > Hi,
> > $ lspci
> > 00:18.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> > Controller (rev 61) 00:18.1 USB Controller: VIA Technologies, Inc.
> > VT82xxxxx UHCI USB 1.1 Controller (rev 61) 00:18.2 USB Controller: VIA
> > Technologies, Inc. USB 2.0 (rev 63)
> >
> > USB driver (endianess???) or oftee or hardware problem?
> >
>  > Anyone experience with VIA USB hardware on PowerPc?
>
> The USB driver should work fine, I have an Efika (MPC5200B) with that
> exact USB controller and revision and it's just fine and dandy. We also
> used to ship Via-based USB cards in the Pegasos Open Desktop Workstation
> (using Marvell Discovery II northbridge).
>
> The major difference here would be that PCI tree entries were created
> by a real OF implementation so may have reflected some hardware better;
> it is dynamically created on boot to a certain point, rather than a fixed
> device tree which may contain some "errors". There seems to be a lot less
> data in our tree...

What Kernel do you run on your target? On my hardware a 2.6.23 still work a=
s=20
expected, but a 2.6.26 fails all the time.

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=C2=A0Pengutronix - Linux Solutions for Science and Industry
=C2=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=C2=A0 =C2=A0 =C2=A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
