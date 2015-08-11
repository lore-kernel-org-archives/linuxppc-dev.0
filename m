Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B41B61A05C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 08:40:48 +1000 (AEST)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DDBA11401F0
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 08:40:47 +1000 (AEST)
Received: by pacrr5 with SMTP id rr5so136815897pac.3
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 15:40:46 -0700 (PDT)
Message-ID: <1439332705.24419.39.camel@axtens.net>
Subject: Re: [PATCH v2 05/10] cxl: Refactor adaptor init/teardown
From: Daniel Axtens <dja@axtens.net>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Date: Wed, 12 Aug 2015 08:38:25 +1000
In-Reply-To: <20150811160120.01815326@camb691>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-6-git-send-email-dja@axtens.net>
 <20150811160120.01815326@camb691>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-EUCKbzIapqxeIBfQdNqj"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-EUCKbzIapqxeIBfQdNqj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Looks like the majority of uses in this file the conditional block is onl=
y
> one line then it makes sense (or at least in terms of numbers of lines...=
 fair
> enough), however, if you have a conditional block spanning multiple lines=
, I
> don't like.
>=20
Much as this is a massive nit pick, I have split out the two
conditionals that spanned multiple lines.

--=20
Regards,
Daniel

--=-EUCKbzIapqxeIBfQdNqj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVynliAAoJEPC3R3P2I92FTngQAIVR5377yxfGJiK9IFbxmUqC
totYEYmtx2GtOTLDZDuy8qk7Qvp+JMqvrW7pwBlbwYg/llDAjVKRHhv5Rwv2Tdbm
TzAij1ZHR5gy7Q3DejuIjz7aFCdS7Ua/9FuyLdnkOh6xUr5EG28pv+facnAnSIy6
Mvy7P5vKkpXGLBOLRcUIenDGf9GAPyhkttm3xSUfaroHID/NBVooHVWHvKUNNzSa
1oL05yZOX816TxJmhFgBlhkiJ/JX4z1ZkW/0jL2QGhaexR0BgOAoB3NXwL27Isbr
o25UT4DLps5677OnLN63Z+5/1m34ALaKU1ZsNb96anlvUf+U/jmP27rebAZFT6ea
0BcmrTFAiiDcSSHM+JzxEsXZ9E2fqlntt1jadVESlRnY2DYy7z9e+y4S+Pw474AO
Iz5D5Pfm1MHb7hsb49f5V4LLxiZAMfVLTwNMpl4mw6PM+2VFV0oBAsNmbaqdILuz
Tfdoiq6NjjDtRbtwfSRfzNv5Fsk9C85jbjc2HXO5MOLtxGfMxJmi23QEV/yvFtnf
xr6ZkteVXirt2DBVqxbPMh4uYxd+jXIQAUi2ZSFNx1WCvP3Uiub6NSOfXJNtyysV
n85588k6VARiDKhUSKbyD7LBEtEIciWgpwQNougEiUuvFOiEBUNpjCAiNrlVLGic
jlF46NjQgCFvP6aGT0eg
=94MV
-----END PGP SIGNATURE-----

--=-EUCKbzIapqxeIBfQdNqj--
