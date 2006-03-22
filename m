Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E3AA3679EA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 11:35:27 +1100 (EST)
Date: Wed, 22 Mar 2006 11:35:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 4/11] powerpc: Replace platform_is_lpar() with a
	firmware feature
Message-Id: <20060322113508.08b07cb4.sfr@canb.auug.org.au>
In-Reply-To: <20060321094630.E7AD067B21@ozlabs.org>
References: <1142934351.193140.181086235013.qpush@concordia>
	<20060321094630.E7AD067B21@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__22_Mar_2006_11_35_08_+1100_kNBGm4S_1DvpxTAY"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__22_Mar_2006_11_35_08_+1100_kNBGm4S_1DvpxTAY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Mar 2006 20:45:59 +1100 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> It has been decreed that platform numbers are evil, so as a step in that
> direction, replace platform_is_lpar() with a FW_FEATURE_LPAR bit.
>=20
> Currently FW_FEATURE_LPAR really means i/pSeries LPAR, in the future we m=
ight
> have to clean that up if we need to be more specific about what LPAR actu=
ally
> means. But that's another patch ...
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Just wondering if you considered just #defining platform_is_lpar() to be
firmware_has_feature(FW_FEATURE_LPAR) ...

Otherwise looks good.

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__22_Mar_2006_11_35_08_+1100_kNBGm4S_1DvpxTAY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIJu8FdBgD/zoJvwRAv0kAJ9QnokdwgDT+vhqcTGjVj8Tu9xa7wCeOh0C
nxEhOlHjX80jbAtSZHQlmic=
=hMyQ
-----END PGP SIGNATURE-----

--Signature=_Wed__22_Mar_2006_11_35_08_+1100_kNBGm4S_1DvpxTAY--
