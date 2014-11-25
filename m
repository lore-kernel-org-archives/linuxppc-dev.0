Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F284D1A0287
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 04:12:44 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53F8514017A
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 04:12:43 +1100 (AEDT)
Date: Tue, 25 Nov 2014 18:14:03 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
Message-ID: <20141125171403.GA9716@katana>
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
 <546DF910.4060802@linux.vnet.ibm.com>
 <20141124121803.GH3733@katana>
 <1416889937.4998.54.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
In-Reply-To: <1416889937.4998.54.camel@kernel.crashing.org>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2014 at 03:32:17PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2014-11-24 at 13:18 +0100, Wolfram Sang wrote:
> >=20
> > I think there are now 3 drivers in my queue which are not fully I2C
> > compatible but more supporting the very minimum to, say, read an
> > eeprom.
> > I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
> > think about ways how to communicate deficiencies like "only 255 byte"
> > or
> > "only WRRD messages" to users of that I2C controller. This is most
> > likely not happening before 3.19. But assistance is very welcome.
>=20
> There are drivers doing that already, this is afaik common practice.

Well, there are drivers doing it, but to me this is somewhere between a
hack and a workaround. Somehow like using subsys_initcall() to overcome
probe ordering issues. That has never been nice and I still don't have a
solution how to convert those drivers back to module_init() + deferred
probe without causing regressions. As a result, people still want to
copy that behaviour.

> Please don't gate the merging process to some hypothetical rework that
> will imply reworking also a number of user space tools and in-kernel i2c
> device drivers. Basically that would mean "your platform won't be
> supported upstream for the next year and btw, rewrite all userspace".

Call me naive but I don't think we need to rewrite all userspace. That
is what I am at least aiming for.

> By all means let's create new "smbus" APIs for >1 bytes offset but let's
> not make it a gate to merging drivers using the existing way of doing
> things that has been so far perfectly functional.

You say "let's", yet my experience is that once I accept a patch like
yours, people are off with their support leaving me alone with the
topic. Not because they are evil, but because they also have tons of
other stuff to do. I perfectly understand I know this myself. And then,
more and more people will come asking for the same as you and the
situation gets harder and harder to fix.

That all being said, the driver has other issues which I will mention in
a seperate thread.


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdLjbAAoJEBQN5MwUoCm2+zcP/jAGYhr6Z9OBzKhW/jykUZCZ
S4CGz/IxsIAyMr58DzkpiRALnjbdvqQ5I0QWSSpgN+UBWj+RP4vvFzT304TYfdy5
3H32qWV1V71DfWySMlxElHGOE/4Ma4gsPL6gOJc0vqfZn7zawqSVV4SMSzLi8rHP
UBbw4kIFInT1RGEgN/iQQWp+pKJop0hffudI6rSAluXzTZgzNIvf4uOsUuotMpZ9
sbhNWvKgC0VK/Eg8bsck+tFCT7HZS8RFwU0u9BelBdVfcNzOAqMdNlSfp42a+ywD
QaoXwosJD9TOq3iF1kbbpzR8/RXqgtUIyVZOlZkeqYNxLmWuSmytPhrRZz5DPPWw
2D3pbvrzTpP9wJI4ESbA5EiHuGYdHYLqmWlu0xKf796cTbVd02/9IVRt8U2XIksP
pw5svyrq3hd56eg01VPJNKkTjj80cm456OeMwd3/8dKYI1I82A08qXUTMR3SlJoU
cshfgbA94TDcrhw4MTdOY6256kWkX6e06FAE7dHlTXOKLIGW2y/sdnmoTv/cB8pB
BYn0oRaDVeqiXOPF8chMPOEl19tY0HEPE6htf4FYBPZwdyt0N0l25j+dwNV8hQ3E
Asa1yXn8urfiQJ0zjvl+4Q3EoMt648W6hA7LzHIZmdScMbYcj+bhSvUiugzHFT8x
k48K1mp1U6ZbbSFt/3Sd
=IVEC
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
