Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A5853DDE47
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 11:53:44 +1000 (EST)
Date: Sun, 22 Jul 2007 11:53:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Someone broke my allmodconfig build
Message-Id: <20070722115354.0c28d704.sfr@canb.auug.org.au>
In-Reply-To: <18082.42674.651685.720737@cargo.ozlabs.ibm.com>
References: <20070722001212.5007001d.sfr@canb.auug.org.au>
	<18082.42674.651685.720737@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__22_Jul_2007_11_53_54_+1000_lZ_7Q_UmDfcSstwz"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__22_Jul_2007_11_53_54_+1000_lZ_7Q_UmDfcSstwz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Jul 2007 10:37:06 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> Stephen Rothwell writes:
>=20
> >   WRAP    arch/powerpc/boot/zImage.ps3
> > /home/sfr/kernels/linus/arch/powerpc/boot/wrapper: line 113: dtc: comma=
nd not found
> > make[2]: *** [arch/powerpc/boot/zImage.ps3] Error 1
>=20
> Hmmm, we should be shipping .dtb files with the tree, so people don't
> have to have dtc installed.

Unless, of course, we ship dtc ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__22_Jul_2007_11_53_54_+1000_lZ_7Q_UmDfcSstwz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGori3TgG2atn1QN8RAvITAJwMfoVXHGaGbpo7b7BgBzGTKscknACgi8B7
wO1Snvw0hax8SLW7Jp1pOKo=
=LNAm
-----END PGP SIGNATURE-----

--Signature=_Sun__22_Jul_2007_11_53_54_+1000_lZ_7Q_UmDfcSstwz--
