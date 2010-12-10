Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (gate.lvk.cs.msu.su [158.250.17.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 64DCAB6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 16:03:25 +1100 (EST)
Date: Fri, 10 Dec 2010 07:52:56 +0300
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
Message-ID: <20101210075256.296752e2@apollo.gnet>
In-Reply-To: <1291854539-23879-1-git-send-email-tmarri@apm.com>
References: <1291854539-23879-1-git-send-email-tmarri@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/rFmbu509DkJdfzIRxfWSUyJ";
	protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/rFmbu509DkJdfzIRxfWSUyJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

=D0=92 Wed,  8 Dec 2010 16:28:59 -0800
tmarri at apm.com (tmarri at apm.com) =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> From: Tirumala Marri <tmarri at apm.com>
>=20
> v6:
>  1. Replaced register definitions and bit fields with macros.
>  2. Replace printks with dev_dbg or dev_err functions.
>  3. Cleanup some assignments.
>  4. Remove chip specific selections in Kconfig file.

Thanks for the update!

I'm currently working on USB support for Ralink RT3050 (mipsel) boards
which have the same USB OTG controller. I've based my work on the
previous version of your patchset. The were several arch-specific issues
that I'd like to be fixed here before it hits mainline (BTW, is it going
to be mainlined?). I'll reply to the subsequent e-mails about the
specific issues. Is this ok?

Also I'd like to note that s3c-hsotg driver that is already in the
kernel seems to be quite similar from the register definitions at least.
It handles gadget mode only and the code looks different. I think it
should be replaced somehow by this new driver (which is based on the
"official" driver).

--=20
  Alexander

--Sig_/rFmbu509DkJdfzIRxfWSUyJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJNAbIoAAoJEElrwznyooJblKoIAIp6C3q5P7Jxf8NeM3F1Ob+k
xQ3xicwyqcf4Hp2lAaBRWXqDjhVcgu00JTdVewBeTqZsP5XTLRcRpAS30e9qJXFx
MzCtb6kKNjwGE7UbdUacFpbAdqfjoKFQYPM676kM6pqgc1fughOWKdrHaazovaoE
Zj1dGzevKujlkKQ6eZUfVwJ23ePzQJQZvfwxm6Ktft7U+yprlvWnLN6pe4+0QyFZ
0ZPRO0EsRwjWeARLqASP3EaTnPsW9UenPJrqThfQ1CIgekedSXD6+GPcqkPOcBkn
PUmqoJPRPPN/4nAYSn8QiHak3KXxoS2g3aB+ZdBT90IH28V1KOQksmbgL/e5k8o=
=8Q22
-----END PGP SIGNATURE-----

--Sig_/rFmbu509DkJdfzIRxfWSUyJ--
