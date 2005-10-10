Return-Path: <Simon.Richter@hogyros.de>
Received: from kleinhenz.com (kleinhenz.com [213.239.205.196])
	by ozlabs.org (Postfix) with ESMTP id 08F63684B3
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 02:49:27 +1000 (EST)
Message-ID: <434A9B87.409@hogyros.de>
Date: Mon, 10 Oct 2005 18:49:11 +0200
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
References: <20051010163349.GA1381@suse.de>
In-Reply-To: <20051010163349.GA1381@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07F106E2873239CE1A4D080A"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: error: implicit declaration of function 'cpu_die'
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07F106E2873239CE1A4D080A
Content-Type: multipart/mixed; boundary="------------050905070208020306050005"

This is a multi-part message in MIME format.
--------------050905070208020306050005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> arch/ppc/kernel/idle.c includes linux/smp.h, which includes asm-smp.h
> only if CONFIG_SMP is defined.
> As a result, cpu_die remains undefined for non-SMP builds.

I have used the attached patch for my tree[1], but this needs to be 
cross-checked with the other architectures.

    Simon

[1] where I merge the APUS stuff by Roman Zippel -- 
http://www.psi5.com/~geier/linux-2.6-apus.git

--------------050905070208020306050005
Content-Type: text/plain;
 name="cpu_die.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cpu_die.diff"

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLXBwYy9zbXAuaCBiL2luY2x1ZGUvYXNtLXBwYy9z
bXAuaAotLS0gYS9pbmNsdWRlL2FzbS1wcGMvc21wLmgKKysrIGIvaW5jbHVkZS9hc20tcHBj
L3NtcC5oCkBAIC02NiwxMSArNjYsNyBAQCBleHRlcm4gc3RydWN0IGtsb2NrX2luZm9fc3Ry
dWN0IGtsb2NrX2luCiAKICNlbmRpZiAvKiBfX0FTU0VNQkxZX18gKi8KIAotI2Vsc2UgLyog
IShDT05GSUdfU01QKSAqLwotCi1zdGF0aWMgaW5saW5lIHZvaWQgY3B1X2RpZSh2b2lkKSB7
IH0KLQotI2VuZGlmIC8qICEoQ09ORklHX1NNUCkgKi8KKyNlbmRpZiAvKiBDT05GSUdfU01Q
ICovCiAKICNlbmRpZiAvKiAhKF9QUENfU01QX0gpICovCiAjZW5kaWYgLyogX19LRVJORUxf
XyAqLwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zbXAuaCBiL2luY2x1ZGUvbGludXgv
c21wLmgKLS0tIGEvaW5jbHVkZS9saW51eC9zbXAuaAorKysgYi9pbmNsdWRlL2xpbnV4L3Nt
cC5oCkBAIC05OSw2ICs5OSw3IEBAIHZvaWQgc21wX3ByZXBhcmVfYm9vdF9jcHUodm9pZCk7
CiBzdGF0aWMgaW5saW5lIHZvaWQgc21wX3NlbmRfcmVzY2hlZHVsZShpbnQgY3B1KSB7IH0K
ICNkZWZpbmUgbnVtX2Jvb3RpbmdfY3B1cygpCQkJMQogI2RlZmluZSBzbXBfcHJlcGFyZV9i
b290X2NwdSgpCQkJZG8ge30gd2hpbGUgKDApCitzdGF0aWMgaW5saW5lIHZvaWQgY3B1X2Rp
ZSh2b2lkKSB7IH0KIAogI2VuZGlmIC8qICFTTVAgKi8KIAo=
--------------050905070208020306050005--

--------------enig07F106E2873239CE1A4D080A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ0qbilYr4CN7gCINAQIivgP/RRyW0Z5L9T9jslx25UBscOqVNc3FLfCF
nLzWZ/7ObrT1YE5xHiDd+aPx4tPaICQeBdeXy+MoA4JMdgVYNwacoUlLw/rUkBqQ
X/gEXu4RXetHdVlXLekl6ZGv9ZYDDxMVBLoNth0f7xqmiPrHo0dygFFUExK1d4aD
gvSrRHLIIb4=
=wxq4
-----END PGP SIGNATURE-----

--------------enig07F106E2873239CE1A4D080A--
