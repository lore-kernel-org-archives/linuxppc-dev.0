Return-Path: <waldi@debian.org>
Received: from wavehammer.waldi.eu.org (wavehammer.waldi.eu.org
	[82.139.201.20]) by ozlabs.org (Postfix) with ESMTP id F20F1DE164
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 23:30:18 +1100 (EST)
Date: Sun, 28 Jan 2007 13:01:26 +0100
From: Bastian Blank <waldi@debian.org>
To: debian-kernel@lists.debian.org, linuxppc-dev@ozlabs.org
Subject: Mac devices on PREP
Message-ID: <20070128120126.GA21984@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Cc: luther@debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks

Currently, the whole bunch of macintosh devices (drivers/macintosh) are
listed to be available on all ppc variants. Some of them does not build
for prep.

The attached patch restricts the whole bunch to PPC_PMAC. I'm not sure
if this is the correct fix.

Bastian

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index a9e747c..0653b3a 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -1,6 +1,6 @@
=20
 menu "Macintosh device drivers"
-	depends on PPC || MAC
+	depends on PPC_PMAC || MAC
=20
 config ADB
 	bool "Apple Desktop Bus (ADB) support"
--=20
Humans do claim a great deal for that particular emotion (love).
		-- Spock, "The Lights of Zetar", stardate 5725.6

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkW8kJYACgkQnw66O/MvCNHU2ACbBtHMoaBc6LCk2/Q6E2FA6qsU
UgsAoKeuS7eIG9y61v9ou4t1nd7lQM5m
=IekW
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
