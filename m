Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F1E42DE0BD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 17:19:49 +1000 (EST)
Date: Tue, 1 Jul 2008 17:19:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Subject: linux-next: manual merge of the net tree
Message-Id: <20080701171940.6f282113.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__1_Jul_2008_17_19_40_+1000_o7xw.kT+YcDiOhly"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Jason Jin <Jason.jin@freescale.com>,
	Jeff Garzik <jgarzik@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__1_Jul_2008_17_19_40_+1000_o7xw.kT+YcDiOhly
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Today's linux-next merge of the net tree got a conflict in  between
commits aee1dc73b519227084d77b0b2fc972b68b4153d8 ("[POWERPC] Update
booting-without-of for Freescale PCIe MSI") and
83ff9dcf375c418ca3b98eb950711525ca1269e2 ("powerpc/sysdev: implement FSL
GTM support") from the powerpc tree and commit
a5edeccb1a8432ae5d9fb9bccea5a4b64c565017 ("net: OpenFirmware GPIO based
MDIO bitbang driver") from the net tree.

They are just overlapping additions. I renumbered(?) the "MDIO on GPIOs"
section to 'v'.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_Jul_2008_17_19_40_+1000_o7xw.kT+YcDiOhly
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhp2owACgkQjjKRsyhoI8xVrQCfYGH7Yh0cdpkLisXntFeHC2d/
sDUAn0fokTgC7nE4/pqxhq3GSI6i8kZn
=oEkA
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Jul_2008_17_19_40_+1000_o7xw.kT+YcDiOhly--
