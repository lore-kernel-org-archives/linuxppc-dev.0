Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5DC12B7149
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:39:36 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4E124DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:39:36 +1000 (EST)
Date: Thu, 11 Jun 2009 11:39:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: linux-next: powerpc tree build warning
Message-Id: <20090611113930.78a42893.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__11_Jun_2009_11_39_30_+1000_3fVsuLRs9p7_AnqZ"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Jun_2009_11_39_30_+1000_3fVsuLRs9p7_AnqZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Today's linux-next build (powerpc ppc64_defconfig) produced this warning:

arch/powerpc/platforms/Kconfig.cputype:60:warning: defaults for choice valu=
es not supported

We appear to have CONFIG_PPC_BOOK3S int two places which is confusing
Kconfig.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__11_Jun_2009_11_39_30_+1000_3fVsuLRs9p7_AnqZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkowYFIACgkQjjKRsyhoI8wSsQCghdrWz+5H8AzA/EKnpZyCGK/e
1P4An2KGXrfT4V5CFWJ24NN9+lP7Es/J
=m21z
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Jun_2009_11_39_30_+1000_3fVsuLRs9p7_AnqZ--
