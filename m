Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 27238B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 22:10:44 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1302EDDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 22:10:44 +1000 (EST)
Subject: powerpc test branch build failure with 6xx defconfig + PERF_CTRS
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-YewrTFVXsU6eG132z4Vb"
Date: Thu, 03 Sep 2009 22:10:43 +1000
Message-Id: <1251979843.5283.6.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-YewrTFVXsU6eG132z4Vb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

With benh's test branch, I'm seeing this trying to build a 6xx defconfig
with CONFIG_PPC_PERF_CTRS=3Dy:

arch/powerpc/kernel/perf_counter.c: In function 'power_check_constraints':
arch/powerpc/kernel/perf_counter.c:352: error: the frame size of 1152 bytes=
 is larger than 1024 bytes

cheers

--=-YewrTFVXsU6eG132z4Vb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqfskAACgkQdSjSd0sB4dLL4QCeIGyoShjWpDw7i/k3NHv5ykcd
4rUAoJpwxPTRogwtCdh+jsy6/rzxl0bq
=GZfs
-----END PGP SIGNATURE-----

--=-YewrTFVXsU6eG132z4Vb--
