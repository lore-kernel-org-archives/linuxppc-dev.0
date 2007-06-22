Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5C9A1DDE38
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 16:03:13 +1000 (EST)
Date: Fri, 22 Jun 2007 16:03:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: Move iSeries_tb_recal from do_settimeofday() into it's own
	late_initcall.
Message-Id: <20070622160302.fbc2e720.sfr@canb.auug.org.au>
In-Reply-To: <20070622054324.GV9768@bakeyournoodle.com>
References: <20070622054324.GV9768@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__22_Jun_2007_16_03_02_+1000_LkZiA=eF_0Qm5gsz"
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__22_Jun_2007_16_03_02_+1000_LkZiA=eF_0Qm5gsz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Jun 2007 15:43:24 +1000 tony@bakeyournoodle.com (Tony Breeds) wr=
ote:
>
> Move iSeries_tb_recal from do_settimeofday() into it's own late_initcall.
>=20
> Currently iSeries will recalibrate the cputime_factors, from the first
> settimeofday() call.
>=20
> It seems the reason for doing this is to ensure a resaonable time delta a=
fter
> time_init().  On current kernels (with udev), this call is made 40-60 sec=
onds
> into the boot process, by moving it to a late initcall it is called
> approximately 5 seconds after time_init() is called.  This is sufficient =
to
> recalibrate the timebase.
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__22_Jun_2007_16_03_02_+1000_LkZiA=eF_0Qm5gsz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGe2YeFdBgD/zoJvwRAo4qAJ9kVR846Y+voZYq0odmbEMVJDAufQCfSqp4
VkvSBp4x0ubyydYoFJkjF5I=
=CSi0
-----END PGP SIGNATURE-----

--Signature=_Fri__22_Jun_2007_16_03_02_+1000_LkZiA=eF_0Qm5gsz--
