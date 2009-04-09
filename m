Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 45962DE135
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 09:11:56 +1000 (EST)
Date: Fri, 10 Apr 2009 09:11:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Message-Id: <20090410091149.5068d8e1.sfr@canb.auug.org.au>
In-Reply-To: <20090409224553.GO16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<7ED93BB3-FE0E-4102-89FB-78950A533717@kernel.crashing.org>
	<20090409224553.GO16602@bilbo.ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__10_Apr_2009_09_11_49_+1000_1qBT=SZP8LB=g0BE"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__10_Apr_2009_09_11_49_+1000_1qBT=SZP8LB=g0BE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Apr 2009 08:45:53 +1000 Tony Breeds <tony@bakeyournoodle.com> wr=
ote:
>
> On Fri, Apr 10, 2009 at 12:46:06AM +0200, Segher Boessenkool wrote:
>=20
> > -Wno-unused or -Wno-unused-pparameter and/or -Wno-unused-variable.  But=
 I
> > thought this was about uninitialised var warnings?  -Wno-uninitialized
> > for that one.
>=20
> Ooops I was asking for -Wno-uninitialized.  I'll try a build with:
> 	-Wno-uninitialized -Wesp
> and see how that goes.

Unfortunately -Wno-uninitialized also suppresses the warnings that point
to real bugs. (but, I guess, the -Wesp might help there :-))

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__10_Apr_2009_09_11_49_+1000_1qBT=SZP8LB=g0BE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknegLUACgkQjjKRsyhoI8zeBQCZAVFn0uHw+CPYec/y+mPNS3tW
aVIAoIJ0QMuf+u+mSKj8KtDU81hb50km
=s43U
-----END PGP SIGNATURE-----

--Signature=_Fri__10_Apr_2009_09_11_49_+1000_1qBT=SZP8LB=g0BE--
