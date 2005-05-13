Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 0F542679FF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 May 2005 03:24:35 +1000 (EST)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xBv0Swrf7GBHO6gatHdB"
Date: Fri, 13 May 2005 13:24:30 -0400
Message-ID: <1116005072.9050.86.camel@jmcmullan.timesys>
Date: Fri, 13 May 2005 13:18:40 -0400
MIME-Version: 1.0
Message-ID: <1116005072.9050.86.camel@jmcmullan.timesys>
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: "PPC_LINUX" <linuxppc-embedded@ozlabs.org>,
	"Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11.7] Swapping OOPS fix for ATA Over Ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-xBv0Swrf7GBHO6gatHdB
Content-Type: multipart/mixed; boundary="=-KO/UJfUyoPtCKubXaLRa"


--=-KO/UJfUyoPtCKubXaLRa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch fixes swapping for devices that do not need to define an
unplug_io_fn().


--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-KO/UJfUyoPtCKubXaLRa
Content-Disposition: attachment; filename=swapping-unplug-oops.patch
Content-Type: text/x-patch; name=swapping-unplug-oops.patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64

RGVzY3JpcHRpb246IEZpeCBPT1BTIHdoZW4gc3dhcHBpbmcgb24gYSBkZXZpY2UgdGhhdCBkb2Vz
bid0IGhhdmUNCglhbiB1bnBsdWdfaW9fZm4gZGVmaW5lZCAoaWUsIEFUQSBPdmVyIEV0aGVybmV0
KQ0KU2lnbmVkLU9mZi1CeTogSmFzb24gTWNNdWxsYW4gPGphc29uLm1jbXVsbGFuQHRpbWVzeXMu
Y29tPg0KDQotLS0gbGludXgtb3JpZy9tbS9zd2FwZmlsZS5jDQorKysgbGludXgvbW0vc3dhcGZp
bGUuYw0KQEAgLTgwLDcgKzgwLDcgQEANCiAJCVdBUk5fT04ocGFnZV9jb3VudChwYWdlKSA8PSAx
KTsNCiANCiAJCWJkaSA9IGJkZXYtPmJkX2lub2RlLT5pX21hcHBpbmctPmJhY2tpbmdfZGV2X2lu
Zm87DQotCQliZGktPnVucGx1Z19pb19mbihiZGksIHBhZ2UpOw0KKwkJYmxrX3J1bl9iYWNraW5n
X2RldihiZGksIHBhZ2UpOw0KIAl9DQogCXVwX3JlYWQoJnN3YXBfdW5wbHVnX3NlbSk7DQogfQ0K



--=-KO/UJfUyoPtCKubXaLRa--

--=-xBv0Swrf7GBHO6gatHdB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBChOLO8/0vJ5szK6kRAjEfAJ988G8q55d34Dbr6HCnFBXxcFhtkwCgr5Zb
mCbHr/HBHUmNaU+qDZJx9oQ=
=r/Zv
-----END PGP SIGNATURE-----

--=-xBv0Swrf7GBHO6gatHdB--
