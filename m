Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0BAEE2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 20:15:09 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id uo1so7705247pbc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 03:15:07 -0700 (PDT)
Date: Thu, 11 Jul 2013 18:14:54 +0800
From: Kevin Hao <haokexin@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] powerpc/85xx: enable the math emulation for the
 corenet64_smp_defconfig
Message-ID: <20130711101454.GD22910@pek-khao-d1.corp.ad.wrs.com>
References: <1373420992-25167-1-git-send-email-haokexin@gmail.com>
 <1373492403.8183.234@snotra>
 <20130711092148.GB22910@pek-khao-d1.corp.ad.wrs.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72DF@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72DF@saturn3.aculab.com>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 11:04:06AM +0100, David Laight wrote:
> > > It'd also be nice if we had an option to only include the portions
> > > of math-emu that are known to be missing in some CPUs (excluding
> > > CPUs that are missing the entire FPU, of course).  Besides its
> > > effect on kernel image size, in my experience math-emu adds a
> > > non-trivial amount of time to a kernel build.
> >=20
> > Sounds reasonable. I will give it a try.
>=20
> It also ought to be possible to use the FPU when emulating the
> missing instructions - rather than using the full 'soft' FPU.

Yes, it is another option. But it may seem a bit risky to do these
floating point arithmetic in kernel space. Do we really want do that?

Thanks,
Kevin

>=20
> 	David
>=20
>=20
>=20

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR3oWeAAoJEJNY7TDerrFxu2YH/ivFAUOeyzyLXnVMcPOO+uwd
9jUFgWsdy60LQ//z73Oz8WAAwvpzaZcnVQ1laKr8Bph26esFygFtAVl42GdLvz0B
nM6xC1XJjD1CgWDWoJxyKlglew7PydxexXafH7l3c3tabpj9Oin68WUZAeBQBNaX
QzKwt5FF41PgutAbHpkf7WRs2VU1ACwlU0jSSjl25P1P0e+Lw3rDazHd+tLfsa/T
DEAVXUM3fD/UeTJMChIzoF8ExH+wKbONIOdClEY6rdPQoHyBi/0aEyFFrUxvJ+Hr
0Kw8IrdkDDbe8mGUWmIKXc6QlaUhJUE4ARGqyvZGcAsi8j2kB9PEn4YvMpFuzxY=
=cdqc
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
