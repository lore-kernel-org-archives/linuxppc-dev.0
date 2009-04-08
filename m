Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 62505DE0C3
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 14:04:16 +1000 (EST)
Date: Wed, 8 Apr 2009 14:04:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: linux-next: build failure
Message-Id: <20090408140407.14dc5242.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__8_Apr_2009_14_04_07_+1000_fApaZDf86MUiO_70"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org, amodra@bigpond.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__8_Apr_2009_14_04_07_+1000_fApaZDf86MUiO_70
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next build (powerpc allyesconfig) failed like this:

  LD      vmlinux.o
powerpc-linux-ld: TOC section size exceeds 64k

I will think about (and appreciate suggestions on) how to fix this ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Apr_2009_14_04_07_+1000_fApaZDf86MUiO_70
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkncIjcACgkQjjKRsyhoI8w6NQCfVtfU/oL6L0UFvH7TzsgnzXvz
3MgAoKdHOOGiDuh4Fxg2hyHpTPNWFLx2
=CFy6
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Apr_2009_14_04_07_+1000_fApaZDf86MUiO_70--
