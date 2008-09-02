Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id 122C3DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 03:18:27 +1000 (EST)
Received: from antares (xdsl-87-79-47-98.netcologne.de [87.79.47.98])
	by smtp4.netcologne.de (Postfix) with ESMTP id A169ADAC16
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 19:18:24 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 70F1CBA06B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 19:18:24 +0200 (CEST)
Date: Tue, 02 Sep 2008 19:18:15 +0200
From: =?UTF-8?q?Albrecht_Dre=C3=9F?= <albrecht.dress@arcor.de>
Subject: Re: Compile new kernel for 5200B w/ ELDK
To: linuxppc-embedded@ozlabs.org
References: <1219770125l.5709l.0l@antares> <m2bpz8j5bw.fsf@ohwell.denx.de>
In-Reply-To: <m2bpz8j5bw.fsf@ohwell.denx.de> (from dzu@denx.de on Mon Sep  1
	16:42:11 2008)
Message-Id: <1220375903l.5712l.0l@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-v94Np/5oWKSaVdgw6U7Z"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--=-v94Np/5oWKSaVdgw6U7Z
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Detlev:

Am 01.09.08 16:42 schrieb(en) Detlev Zundel:
> Use a recent kernel version.  2.6.26 should work out of the box =20
> without too much hassle.  Some of the older versions had problems =20
> effectively stalling Linux very early without any output on the =20
> console.

Thanks a lot for your hint, but unfortunately it doesn't solve my =20
problem:
- downloaded 2.6.26.3 from kernel.org;
- called "make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- =20
52xx/lite5200b_defconfig";
- called "make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- uImage".

However, even with "console=3DttyPSC0,115200 verbose panic=3D1" in the =20
bootargs, the kernel simply doesn't say /anything/ after decompression:

<snip>
=3D> bootm
## Booting kernel from Legacy Image at 01000000 ...
    Image Name:   Linux-2.6.26.3
    Created:      2008-09-02   9:11:12 UTC
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    1341904 Bytes =3D  1.3 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
</snip>

Do I understand the remark in =20
Documentation/powerpc/booting-without-of.txt, section "The /chosen =20
node", correctly that it is *not* necessary to add it to the dts file =20
as u-boot 1.3.4 should fill it in automatically?  Anyway, adding this =20
section doesn't change anything...

HELP!  I'm really lost here...

Thanks, Albrecht.

--=-v94Np/5oWKSaVdgw6U7Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBIvXVfn/9unNAn/9ERAnsXAKCekkWL9T4yulUbsZriER0mrAlS8ACgj9oG
cVL5Gq/sk5NYoGJ9CMTyJ1s=
=MIlT
-----END PGP SIGNATURE-----

--=-v94Np/5oWKSaVdgw6U7Z--
