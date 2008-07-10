Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E627DDDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 14:15:51 +1000 (EST)
Date: Thu, 10 Jul 2008 14:15:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: linux-next: manual merge of the galak tree
Message-Id: <20080710141536.368780e3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jul_2008_14_15_36_+1000_U9r17JGngGQmCUD7"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Jul_2008_14_15_36_+1000_U9r17JGngGQmCUD7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

Today's linux-next merge of the galak tree got a conflict in
Documentation/powerpc/booting-without-of.txt between commit
a5edeccb1a8432ae5d9fb9bccea5a4b64c565017 ("net: OpenFirmware GPIO based
MDIO bitbang driver") from the net tree and commit
a5b420dc2ff8423b30506e805584f30875b5fb57 ("powerpc/fsl: Refactor device
bindings") from the galak tree.

I left the "MDIO on GPIOs" section there and relabeled it as 'g'.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jul_2008_14_15_36_+1000_U9r17JGngGQmCUD7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh1jOgACgkQjjKRsyhoI8z+ygCcDhhwhaz0zYEn6GIZ6QO0dVXW
iQMAn3ybS9i6ZBsy5vM34DpRo67u0vhK
=D0rr
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jul_2008_14_15_36_+1000_U9r17JGngGQmCUD7--
