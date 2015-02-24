Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BC241A1137
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 01:17:02 +1100 (AEDT)
Date: Tue, 24 Feb 2015 15:16:44 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
Message-ID: <20150224141644.GA18301@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
 <CABuKBe++yut6ZfhPrsWXGA4fZRvum6WOuRxHucM0gBJCGuou5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <CABuKBe++yut6ZfhPrsWXGA4fZRvum6WOuRxHucM0gBJCGuou5A@mail.gmail.com>
Cc: linux-mips@linux-mips.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +               if (msgs[i].flags & I2C_M_RD) {
> > +                       if (i2c_quirk_exceeded(len, max_read))
> > +                               return i2c_quirk_error(adap, &msgs[i], =
"msg too long");
> > +               } else {
> > +                       if (i2c_quirk_exceeded(len, max_write))
> > +                               return i2c_quirk_error(adap, &msgs[i], =
"msg too long");
> > +               }
>=20
> What about being more verbose in the error message, specifying if it
> was a read or a write message that failed?

Yes, done now. Thanks!


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7IfLAAoJEBQN5MwUoCm2eM4P+wQZaq6QCo0vjXPKuf28kwn7
pE8alO7Mref/hDPDtJr/f7wFWnZkhQm0frwFxkMjkk7AXU/423Hr+WaynTn2muPU
JsQCTXbHJ7FRk9I/k0ZlRyxDhOYM5pAX4y/M+L5rA9HvNFWDcchOaiq4ep3BpyDB
xRRdXwMJHDylJJnbq/HEuXbNBXOex4qvCrAhXemdR9XYLCVenhMnBjztvkB48XDQ
PXCBuf43NtjY3C0P7fbFnnGUP+t+Zhdzup9JYJKaroJKd8XgrViSCv9qog6xgUO2
n5QzR5RwQCy4dQ8fhNteNJ5xJpTEQfV0qrTpGqqOBOtyZLtj+hjeEk8tBI4c+DJ2
24Z4rVc3q0QfyL8o2T4IbIg7kRxlk+8M2RzEVy2tRpNmUlKtW8hLVrRADTJGyLR/
XntU9Afl+qBnRwaP8IodZDE2xD5wTCwyo8L/4+/+q3Bo6mYxKkpOl43yDbDwJX6S
c5c9K+ueyWxILGkmJ+dgHMNySI5G0uDq8BG5dLpbx5iDUZfZBZ/TZtrpnrl5PiR5
kYkWJQ2L/P9CIer+v2Ia0e2XrYu8sVP/Cm38MsDRCiFHYj2qXREPMH6wY5Rf/wpH
0hvntc8pvr1YkMMD4aOaeQAdsSXe63P/4Q4pjaWbqupdW5cWgzelSUJoLVc3Lhil
2bx8Bd80/Y1UvyJBIbgi
=ERJg
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
