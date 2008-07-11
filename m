Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 431A2DE0DD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 17:45:31 +1000 (EST)
Date: Fri, 11 Jul 2008 17:45:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: benh@kernel.crashing.org, paulus@samba.org, npiggin@suse.de, Jon
	Tollefson <kniht@linux.vnet.ibm.com>
Subject: gigantci pages patches
Message-Id: <20080711174515.1aacf83b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_Jul_2008_17_45_15_+1000_.1BXtm7mzPGE.8Pu"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_Jul_2008_17_45_15_+1000_.1BXtm7mzPGE.8Pu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Could people take one last look at these patches and if there are no
issues, please send Ack-bys to Andrew who will push them to Linus for
2.6.27.

[PATCH 1/6 v2] allow arch specific function for allocating gigantic pages
http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18437
Patch: [PATCH 2/6 v2] powerpc: function for allocating gigantic pages
http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18438
Patch: [PATCH 3/6 v2] powerpc: scan device tree and save gigantic page loca=
tions
http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18439
Patch: [PATCH 4/6 v2] powerpc: define page support for 16G pages
http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18440
Patch: [PATCH 5/6 v2] check for overflow
http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18441
Patch: [PATCH 6/6] powerpc: support multiple huge page sizes
http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18442

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_Jul_2008_17_45_15_+1000_.1BXtm7mzPGE.8Pu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh3D4sACgkQjjKRsyhoI8yVJwCfUEzxb+bNnTf8SxtyQKofsGrL
S3QAoJUwVyknQtxn1Xu9F0wm2LCr/tbF
=no3H
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Jul_2008_17_45_15_+1000_.1BXtm7mzPGE.8Pu--
