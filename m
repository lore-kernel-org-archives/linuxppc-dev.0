Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E3658DDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 14:59:19 +1000 (EST)
Date: Thu, 15 May 2008 14:59:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: linux-next: powercp-next build failure
Message-Id: <20080515145913.5436adb9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__15_May_2008_14_59_13_+1000_GwRe1pIpjZ1T=AYL"
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-next@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__15_May_2008_14_59_13_+1000_GwRe1pIpjZ1T=AYL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next build (sparc64 defconfig) fails like this:

drivers/of/device.c: In function `modalias_show':
drivers/of/device.c:66: error: implicit declaration of function `of_device_=
get_modalias'

Caused by commit 140b932f8cb6cced10b96860651a198b1b89cbb9 ("[POWERPC]
Create modalias file in sysfs for of_platform bus") from the powerpc-next
tree as there is a definition and declaration of of_device_get_modalias
only for powerpc.  I reverted that commit for today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__15_May_2008_14_59_13_+1000_GwRe1pIpjZ1T=AYL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIK8MmTgG2atn1QN8RAu4rAJ0QGvs4Yt8IvHqOeV7Z69ZqdHsjaACeNWYH
sbIM8bntnRcfv+yuYDaQdmU=
=UEL/
-----END PGP SIGNATURE-----

--Signature=_Thu__15_May_2008_14_59_13_+1000_GwRe1pIpjZ1T=AYL--
