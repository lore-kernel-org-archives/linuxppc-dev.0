Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 08736DDF04
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 14:04:23 +1000 (EST)
Date: Tue, 20 May 2008 14:04:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/7] [POWERPC] QE: add support for QE USB clocks routing
Message-Id: <20080520140413.5ae74d65.sfr@canb.auug.org.au>
In-Reply-To: <20080519174655.GB28185@polina.dev.rtsoft.ru>
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174655.GB28185@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__20_May_2008_14_04_13_+1000_k7PD1h9oyhmPEHKp"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__20_May_2008_14_04_13_+1000_k7PD1h9oyhmPEHKp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Mon, 19 May 2008 21:46:55 +0400 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +++ b/arch/powerpc/sysdev/qe_lib/usb.c

> +#include <linux/of.h>

Nothing in this file requires anything in linux/of.h or asm/of.h ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__20_May_2008_14_04_13_+1000_k7PD1h9oyhmPEHKp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIMk3BTgG2atn1QN8RAnDhAJ9QIjaAAyyAC/ViPFtWmh8J4nTDhACfUsDh
40gqCNAJdXf1oiqgUfv7Toc=
=R42W
-----END PGP SIGNATURE-----

--Signature=_Tue__20_May_2008_14_04_13_+1000_k7PD1h9oyhmPEHKp--
