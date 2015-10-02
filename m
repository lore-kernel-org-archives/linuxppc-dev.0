Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 034351A01FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 14:17:18 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so97170783pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2015 21:17:16 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 18/34] cxlflash: Fix AFU version access/storage and add
 check
In-Reply-To: <A8B191C3-D4C7-49ED-A058-95443BABDBDC@linux.vnet.ibm.com>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443715012-18236-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <87h9maay0s.fsf@gamma.ozlabs.ibm.com>
 <A8B191C3-D4C7-49ED-A058-95443BABDBDC@linux.vnet.ibm.com>
Date: Fri, 02 Oct 2015 14:17:01 +1000
Message-ID: <87bnchc3b6.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:

> Correct, downlevel (unsupported) AFUs don't implement the interface_version
> register and thus will return -1 at that offset.
Cool. It would be good to document that somewhere, either the comment or
the commit message, but it's not worth holding up the series for it.

I also tend to use the form (var == ~0ULL) for tests like this but
that's an aesthetic thing.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWDgU9AAoJEPC3R3P2I92FPbsP/1zuJwbxi1KeYKX3Abup47DU
E8R4H7+lzYotRbNSZkGedsPTN3Jte2sYgpzO/xYJCuvtlH5dDDOADg/n3VVEcnFG
yayZLnm2whHM4I+QjBKsEOMYHdKDQ2Y22Py8IrMDQFeivLHUgw3mqW40h8WChIdw
WeMbcQJFer9+VU1pnXoUkL60/KP+7usA+Q169ahYlzneAcn19JdXneProBFAGzLm
dMDJkaDmlvCJarp/VPwkOrQ54iKYqmOpY6mdvyeUpF4YLybfi8wOMOz0VQEbHuMt
MbnfAq2Sf3xGpa1J5fIMCA4Rvruw1zgo1Ypa5scEsLhd40/V/kSbWKr0ETyecoHE
K6Wb+HFUlXyqoytGFy04ORlXqLakP1V6exmNdFEnOy56RSZppviuHQR+YbeuYktT
KZh/sL8L0x0s2CP6E99AGzgsh7Xl05Oa1xlQP7+jbQMhnX2bikewf7maNbPZwHHm
i3419byQTKZxT5e8YpSddhWkSCIO2A/i6DBUIyk+lL80n5swJETlLiDbYD/+JhsY
jx0uzbuqtVNgSLP9I4IgTDdwrdzOE9f8hgmb9OCXmwAvU25MJ/EgtyAxH8nAg8X6
vQjhHXc9jF23SkKGuml76TjG6kWQ4pqPohYQKC4If3R7qYtyYsQInuSB6CnNNqBi
Yz4ljx2xSkNJCMJWO6Jr
=nAm2
-----END PGP SIGNATURE-----
--=-=-=--
