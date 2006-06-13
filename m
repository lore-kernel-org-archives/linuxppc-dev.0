Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5505B67B1E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 20:26:22 +1000 (EST)
Received: from [131.234.74.208] (helo=dhcp-74-208.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.62) (envelope-from <johannes@sipsolutions.net>)
	id 1Fq65w-00053v-QA
	for linuxppc-dev@ozlabs.org; Tue, 13 Jun 2006 11:26:01 +0100
Subject: 32 bit userland on G5
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CM2iznjEMeDdTsPeaZIC"
Date: Tue, 13 Jun 2006 12:25:48 +0200
Message-Id: <1150194348.9208.33.camel@johannes>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CM2iznjEMeDdTsPeaZIC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Since apparently the G5 honours no-execute permissions, shouldn't the 64
bit kernel set the READ_IMPLIES_EXEC personality flag for 32-bit
userland?

The memory being execute-protected is causing a mono bug
(http://bugzilla.ximian.com/show_bug.cgi?id=3D77028) but I'm not sure
where the correct fix would be, currently the kernel doesn't seem to be
behaving exactly the same on G4 and G5.

johannes

--=-CM2iznjEMeDdTsPeaZIC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARI6SqqVg1VMiehFYAQL13A/9HiNPuOPlG0qOFpM3kOpjFlqapwQr5AZt
TUc+rp4Ar40mqKNN2scL9+0oOmQfqTFbgv0ScnG5pbJ6l3f/rpNlmtwN7Qb0aG3H
fiHaFuovK7/STEwtOWvQ02Y3NTwHK/t6dLa6CLV4tQwjQhRKid6RZENKFcDa9L4L
IAvZ5nd413BxkdUUPnlKT/77czS4TBCQGhML85c+CmurRdykVMf+qj6lH5iw0IuZ
31lYRrpSXYlmWSO+4n4UMoTRck21qfopYt9h+mPlLuf7cy6Tb6i7t+0qcniJLQ0Q
4BAbJio4UqfWOS3GhrdbncX+fDKz2wewect3GUFhDNHCtwTJGQ+9JbEPRD14oz9M
fNwdfTFdSlURpuidEzo/3VQGjSkbMiDeppi5IYwcmlfqzwxaALo3Wj8A6wV/NAUy
l5AlraizHNGNAw9NkmsztEIbSw79fb2s6ZKv+9I0cumHBPkmsi4l73tn4grybvVF
nGYrPZm9cyFKKlGfz01Y09Lorycd1fPG9StAtWWt9C01J+YmaO6jiCDjbiBLhikY
Eoi3mhmCgGwWy+kigG62mNBfm6jOIl7qFUTGubtYnVf1Nr//pHDBaok7MCr02aO8
NxxQhQXf7tiTr1AD+bqWvBoyJZpXQSOaEqZSNfyaMw4lbh1lWjeus+lpj0xsVAxP
aqprsWOCtEE=
=7SIq
-----END PGP SIGNATURE-----

--=-CM2iznjEMeDdTsPeaZIC--
