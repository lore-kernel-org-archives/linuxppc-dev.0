Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1542DB7D25
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 16:00:05 +1100 (EST)
Date: Wed, 17 Mar 2010 15:59:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rupjyoti Sarmah" <rsarmah@amcc.com>
Subject: Re: [PATCH] 460EX on-chip SATA driver<kernel 2.6.33> < resubmission
	: 01>
Message-Id: <20100317155959.208eea21.sfr@canb.auug.org.au>
In-Reply-To: <AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com>
References: <1268646854-27387-1-git-send-email-rsarmah@appliedmicro.com>
	<AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__17_Mar_2010_15_59_59_+1100_x6xtbWF6Ja6n4J16"
Cc: Rupjyoti Sarmah <rupjyoti.sarmah@appliedmicro.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Rupjyoti Sarmah <rupjyoti.sarmah@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__17_Mar_2010_15_59_59_+1100_x6xtbWF6Ja6n4J16
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Just a couple of quick points ...

On Tue, 16 Mar 2010 21:23:16 -0700 "Rupjyoti Sarmah" <rsarmah@amcc.com> wro=
te:
>
> This patch enables the on-chip DWC SATA controller of the AppliedMicro
> processor 460EX.
>=20
> Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com> ,Mark Miesfeld
> <mmiesfeld@appliedmicro.com>,
> Prodyut Hazarika <phazarika@appliedmicro.com>

Please put one Signed-off-by line per person.

> ---
>  arch/powerpc/boot/dts/canyonlands.dts |    8 +
>  drivers/ata/Kconfig                   |    9 +
>  drivers/ata/Makefile                  |    1 +
>  drivers/ata/sata_dwc.c                | 1965
> +++++++++++++++++++++++++++++++++
>  4 files changed, 1983 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c

This patch has been word wrapped by your mailer (or something along the
way).
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__17_Mar_2010_15_59_59_+1100_x6xtbWF6Ja6n4J16
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkugYc8ACgkQjjKRsyhoI8zZJQCfZJSGnsbt4kh9bMNqgMk2m+wB
IwAAn0mM+SEn8+ALw6LQIjSK8BbR2KMr
=hvS3
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Mar_2010_15_59_59_+1100_x6xtbWF6Ja6n4J16--
