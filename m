Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 45D75DDFEA
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 13:39:16 +1000 (EST)
Date: Thu, 3 Jul 2008 13:39:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: manual merge of the powerpc tree
Message-Id: <20080703133905.7b6f058f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__3_Jul_2008_13_39_05_+1000_BS=pLOyUzYESdm3O"
Cc: Jean Delvare <khali@linux-fr.org>, linux-next@vger.kernel.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__3_Jul_2008_13_39_05_+1000_BS=pLOyUzYESdm3O
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next merge of the powerpc tree got a conflict in
arch/powerpc/sysdev/fsl_soc.c between commit
4eac6a8b17ce5ebe66eb94b6a0b43aa3a2bf7ea6 ("i2c-mpc: Convert to an
of_platform driver") from the i2c tree and commits
22fb7d9be593181e2f779cf7a8421703a6be713b ("[POWERPC] fsl: Add warning for
unrecognized I2C nodes in the device tree"),
64f9b5ee17ee7974d7cc58d75221432d86960ba3 ("[POWERPC] fsl: Add CS4270 i2c
data to fsl_soc.c") and e026892c85571e12f11abffde5a90bcc704d663e
("[POWERPC] fsl: Update fsl_soc to use cell-index property of I2C nodes")
from the powerpc tree.

The changes from the powerpc tree modify code that the i2c tree removes.
I used the i2c tree's version, but someone should check the result.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_Jul_2008_13_39_05_+1000_BS=pLOyUzYESdm3O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhsSdkACgkQjjKRsyhoI8x0/gCgrwERbKr5w5TCuKaW5zmqSOZo
CjMAn3Lesx5q9ogDarnWL0e/5wJlmMm+
=7q+g
-----END PGP SIGNATURE-----

--Signature=_Thu__3_Jul_2008_13_39_05_+1000_BS=pLOyUzYESdm3O--
