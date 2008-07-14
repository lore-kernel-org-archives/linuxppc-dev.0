Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7D741DDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 18:21:31 +1000 (EST)
Date: Mon, 14 Jul 2008 18:21:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: powerpc/master: build failure
Message-Id: <20080714182118.f5a20643.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Jul_2008_18_21_18_+1000_a3AZAEbQXPjn+zq9"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__14_Jul_2008_18_21_18_+1000_a3AZAEbQXPjn+zq9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

A build of today's powerpc/master tree for mpc85xx_defconfig fails like thi=
s:

DTC: dts->dtb  on file "arch/powerpc/boot/dts/ksi8560.dts"
ERROR (phandle_references): Reference to non-existent node or label "mpic"
ERROR (phandle_references): Reference to non-existent node or label "mpic"
ERROR (phandle_references): Reference to non-existent node or label "mpic"
ERROR (phandle_references): Reference to non-existent node or label "mpic"
ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [arch/powerpc/boot/ksi8560.dtb] Error 2

Probably commit dee805532a30183c4462305b4614e58bd83a7bc1 ("powerpc: Add
dma nodes to 83xx, 85xx and 86xx boards").

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Jul_2008_18_21_18_+1000_a3AZAEbQXPjn+zq9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh7DH4ACgkQjjKRsyhoI8wlYACglSEd9ze42j0RC2qAY32fBqit
r4oAn22YY9eO1+HvZXmEXNnoedQifIq4
=I9l8
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Jul_2008_18_21_18_+1000_a3AZAEbQXPjn+zq9--
