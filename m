Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4439FDDE39
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:38:10 +1100 (EST)
Date: Fri, 18 Jan 2008 11:38:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFCv2] [POWERPC] Add support for freescale watchdog to
	CPM serial driver.
Message-Id: <20080118113804.4d4fdcc5.sfr@canb.auug.org.au>
In-Reply-To: <478F4AE3.5090803@scram.de>
References: <478F4AE3.5090803@scram.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__18_Jan_2008_11_38_04_+1100_hhjUuxYvI1oUHO91"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__18_Jan_2008_11_38_04_+1100_hhjUuxYvI1oUHO91
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jan 2008 13:32:35 +0100 Jochen Friedrich <jochen@scram.de> wrote:
>
> If a freescale watchdog device node is present, reset the watchdog
> while waiting for serial input.
>=20
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/powerpc/boot/Makefile     |    2 +-
>  arch/powerpc/boot/cpm-serial.c |    6 ++++
>  arch/powerpc/boot/cuboot-8xx.c |    1 +
>  arch/powerpc/boot/ops.h        |    2 +
>  arch/powerpc/boot/watchdog.c   |   65 ++++++++++++++++++++++++++++++++++=
++++++

I am just wondering if maybe that file name is to generic.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__18_Jan_2008_11_38_04_+1100_hhjUuxYvI1oUHO91
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHj/TwTgG2atn1QN8RAtjeAJ9OK5TKKqICD1rV+bHfx+HLknUxgACfcp98
hgnGoOHVPdSDbhN0wzfJ7cU=
=2Xdv
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Jan_2008_11_38_04_+1100_hhjUuxYvI1oUHO91--
