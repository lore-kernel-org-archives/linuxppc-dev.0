Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0B2AAB707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 08:28:02 +1000 (EST)
Date: Thu, 1 Jul 2010 08:27:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix compile errors in prom_init_check for gcc 4.5
Message-Id: <20100701082756.7dced805.sfr@canb.auug.org.au>
In-Reply-To: <B6229BDC-F290-4A71-9F61-AAA5EC87F0F6@kernel.crashing.org>
References: <20100630160422.3087bdf0.sfr@canb.auug.org.au>
	<B6229BDC-F290-4A71-9F61-AAA5EC87F0F6@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__1_Jul_2010_08_27_56_+1000_ilN7N8/9lhiTAxGt"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__1_Jul_2010_08_27_56_+1000_ilN7N8/9lhiTAxGt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Segher,

On Thu, 1 Jul 2010 00:16:40 +0200 Segher Boessenkool <segher@kernel.crashin=
g.org> wrote:
>
> I've used an identical patch for almost a year now, so...
>=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks.

> You probably also need something similar to http://git.infradead.org/=20
> users/segher/linux.git/commitdiff/=20
> 98194f54cc8e19ecd752bc10e2d19ef94074f502
> (note: only build-tested, not run-tested).

See http://patchwork.ozlabs.org/patch/57379/ submitted yesterday.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__1_Jul_2010_08_27_56_+1000_ilN7N8/9lhiTAxGt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMK8TsAAoJEDMEi1NhKgbsXY4IAKA72ARvrLJZYnBm2nIayRzF
KNOI8mRgL8N/WhtM6L1Yx+gVi/AcUllgE8kieBhrz+3AlBICCHr7oXoc9URmeOTL
iTwxArqxPSIk0bLBuqweYbC840XaswG9ajOxSsw9NepZaEcuO0+08wxFWdzw+wiT
UaaLSDnQoowQxfJTN7Pde6NTRZs+iMVuaee4dCRonLQ2C58bHf+djlCmb+TkwYLg
Gri50qPqutMZG9yRIqsnWgcl51/9ammXh4bwnW0HAKdjKFleGYcP6E333KHzP69d
vUqIrceS89LVytprr8tLP6bAiy2VsVvG+64V+uD7SMIEZ8myGdk+0t5T+ZNSUvE=
=op8V
-----END PGP SIGNATURE-----

--Signature=_Thu__1_Jul_2010_08_27_56_+1000_ilN7N8/9lhiTAxGt--
