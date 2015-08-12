Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D9B41A1D6A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 08:01:02 +1000 (AEST)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 11CA41402C4
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 08:01:00 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so22793912pab.0
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 15:00:59 -0700 (PDT)
Message-ID: <1439416707.6621.0.camel@axtens.net>
Subject: Re: [PATCH v2 05/10] cxl: Refactor adaptor init/teardown
From: Daniel Axtens <dja@axtens.net>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Cyril Bur' <cyrilbur@gmail.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "mikey@neuling.org" <mikey@neuling.org>,
 "imunsie@au.ibm.com" <imunsie@au.ibm.com>
Date: Thu, 13 Aug 2015 07:58:27 +1000
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB794DF@AcuExch.aculab.com>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-6-git-send-email-dja@axtens.net>
 <20150811160120.01815326@camb691>
 <063D6719AE5E284EB5DD2968C1650D6D1CB794DF@AcuExch.aculab.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-i49oUoETXkrkyV9Xy3z6"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-i49oUoETXkrkyV9Xy3z6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The function above doesn't even use the 'rc' value.

Darn, you're right.

I'll fix that in a new version.

--=20
Regards,
Daniel

--=20
Regards,
Daniel

--=-i49oUoETXkrkyV9Xy3z6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVy8GNAAoJEPC3R3P2I92F6PUQAK4Nm7zrsMylM+bxHFFKNqRx
mj+MWBK8Y0jpntvTKHuZyHBRR8ZlBhspVUVol6G+nuhKMsl4eYiHQqKQ2Sk4EouD
aReKOkTKpMjFILoSGOvj0K6TDKsr9rO0NJQbXau5VdkVIqwgt2N2IzToGwg4QKtS
U5xvSYh8CHvnxOIbCsOz3pO8uYdkamkKEtAjmyG06Ip5dvcs0VbuioTnKS8amKRF
K5I43+6CmFKbjplBhUGiocSPosfArt7g6okO8Hp4WMG5z0yBbcm5KB7IZ5H6kciA
i9Nrh6AJj5fcPduNwmwDK4vbNGyKXSZ2RaMMX0ppfAwnCLrBVEbVo9fMazbpV2//
8ezAxC8Fv7iCE7wwQCI1558YxglRsFfo84HjtRob+fvuVCrgPtMWUccnBbUHcsJ9
QaQvuv5VY54CP0N9wNzlwXyHKPDtBNQipQWYjC5llo99l0H8K1j3+MHrZZEMPKGs
EtLL7aZUPc/xJyA9+MeCK7mEyta/YTWxiLjLcW/74oxxRO1YRky1VJta1KrpbjK5
553OxkW37iB23fXOUu2lNavTBK4VKF6u/1stB9HAB5SDVZ06h7iKgEBLVQRnyhtj
pLINM21ky1aD43Pe4Y2gKXWATvfwvlZQEAjDXv33/rp/shZsIjsbv01g4cYVjtI+
l0znudcMl8DXoTFduJ5D
=cImt
-----END PGP SIGNATURE-----

--=-i49oUoETXkrkyV9Xy3z6--
