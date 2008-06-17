Return-Path: <wangbj@dslab.lzu.edu.cn>
Received: from mail.dslab.lzu.edu.cn (unknown [202.201.1.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0832DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jun 2008 14:45:16 +1000 (EST)
Received: from [192.168.2.104] (unknown [202.201.14.140])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dslab.lzu.edu.cn (Postfix) with ESMTP id 2146084A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jun 2008 12:45:11 +0800 (CST)
Subject: IBM_NEW_EMAC should depends on CONFIG_CRC32??
From: "Wang, Baojun" <wangbj@dslab.lzu.edu.cn>
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pfthfUUuQdBppQYxJtFi"
Date: Tue, 17 Jun 2008 12:45:08 +0800
Message-Id: <1213677908.17375.5.camel@localhost.dslab>
Mime-Version: 1.0
Reply-To: wangbj@dslab.lzu.edu.cn
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-pfthfUUuQdBppQYxJtFi
Content-Type: multipart/mixed; boundary="=-H/4wnXRNC+dGQsRnv+XT"


--=-H/4wnXRNC+dGQsRnv+XT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

kernel is the lastest (linus linux-2.6.git) version, and IBM_NEW_EMAC
doesn't depend on CONFIG_CRC32 (but it does), which will cause the
following error:

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `emac_hash_mc':
core.c:(.text+0x2f524): undefined reference to `crc32_le'
core.c:(.text+0x2f528): undefined reference to `bitrev32'
make: *** [.tmp_vmlinux1] Error 1

the attachment is the .config file.

After select CONFIG_CRC32 the problem is resolved.

  Regards,
Wang
--=20
Wang, Baojun                                                Lanzhou Univers=
ity
Distributed & Embedded System Lab                      http://dslab.lzu.edu=
.cn
School of Information Science and Engeneering          wangbj@dslab.lzu.edu=
.cn
Tianshui South Road 222. Lanzhou 730000                             .P.R.Ch=
ina
Tel: +86-931-8912025                                      Fax: +86-931-8912=
022


--=-H/4wnXRNC+dGQsRnv+XT
Content-Disposition: attachment; filename=config-amcc-yosemite.gz
Content-Type: application/x-gzip; name=config-amcc-yosemite.gz
Content-Transfer-Encoding: base64

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


--=-H/4wnXRNC+dGQsRnv+XT--

--=-pfthfUUuQdBppQYxJtFi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: 
	=?gb2312?Q?=D5=E2=CA=C7=D0=C5=BC=FE=B5=C4=CA=FD=D7=D6=C7=A9?=
	=?gb2312?Q?=C3=FB=B2=BF=B7=D6?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhXQVQACgkQIuIOr7tpgg3crgCeMZpHbb45QbRnU0vPJFYx08wW
WEwAoJzIf01t7zBgqQFbPHFq+qnIjedI
=3Qfr
-----END PGP SIGNATURE-----

--=-pfthfUUuQdBppQYxJtFi--
