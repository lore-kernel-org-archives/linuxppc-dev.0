Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 43319DDF69
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 13:27:06 +1100 (EST)
Date: Tue, 14 Oct 2008 12:02:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: manual merge of the powerpc tree
Message-Id: <20081014120229.2c20515a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__14_Oct_2008_12_02_29_+1100_b9Ao5KxsqI_rBYI6"
Cc: Victor Gallardo <vgallardo@amcc.com>, linux-next@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__14_Oct_2008_12_02_29_+1100_b9Ao5KxsqI_rBYI6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul, Ben,

Today's linux-next merge of the powerpc tree got a conflict in
drivers/net/ibm_newemac/core.h between commit
6fbc779c03591ee536fef9efb7d7e20f281d0b5c ("ibm_newemac: Fix EMAC soft
reset on 460EX/GT") from Linus' tree and commit
b68d185ab12b1fc8000432c5d5ab5404d4788b4c ("ibm_newemac: Allow the "no
flow control" EMAC feature to work") from the powerpc tree.

Just overlapping additions.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__14_Oct_2008_12_02_29_+1100_b9Ao5KxsqI_rBYI6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjz76UACgkQjjKRsyhoI8zOngCfXwiQQCKH46y2xpWuiDwyW/rV
n9sAn0IQnfAOnpcnbSlw761j8Bjr98Vm
=Bx/q
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Oct_2008_12_02_29_+1100_b9Ao5KxsqI_rBYI6--
