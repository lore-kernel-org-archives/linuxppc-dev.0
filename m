Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 509C6DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 20:38:13 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 19 Sep 2007 12:37:59 +0200
References: <20070810095153.GC13994@moe.telargo.com>
	<9e4733910709181229m4afe7ecr56e2411f52a84232@mail.gmail.com>
	<BLU106-W49D16A32DDFE2611E15371CAB90@phx.gbl>
In-Reply-To: <BLU106-W49D16A32DDFE2611E15371CAB90@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709191238.00183.jbe@pengutronix.de>
Subject: Re: [PATCH] phy: export phy_mii_ioctl
Cc: netdev@vger.kernel.org, Domen Puncer <domen@coderock.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pedro,

On Wednesday 19 September 2007 10:54, Pedro Luis D. L. wrote:
> I=B4m also working with a Phytec pcm030, but I can=B4t get it booted...
> Which kernel are you using?
> I tried to apply the 7 bestcomm patches from Sylvain and patch over these
> with this new ones that Domen released. The base kernel I=B4m using is
> 2.6.22.6 from kernel.org.
> Although I used the patch that creates pcm030.c in arch/platforms/52xx/ a=
nd
> compiled using this file, it gets halted at booting time.
>
> Bytes transferred =3D 5091 (13e3 hex)
> ## Booting image at 00500000 ...
>    Image Name:   Linux-2.6.22.6
>    Created:      2007-09-19   8:53:02 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1196911 Bytes =3D  1.1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using flat device tree at 0x400000
>
> (No more output and boot is halted)

Check your oftree! Most of the time this behaviour means its a wrong oftree=
 in=20
use.

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
