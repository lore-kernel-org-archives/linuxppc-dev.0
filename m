Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 520FC1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 23:16:40 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D9927140081
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2014 23:16:39 +1100 (AEDT)
Date: Mon, 24 Nov 2014 13:18:04 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
Message-ID: <20141124121803.GH3733@katana>
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
 <546DF910.4060802@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
In-Reply-To: <546DF910.4060802@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 07:52:08PM +0530, Neelesh Gupta wrote:
>=20
> On 11/16/2014 10:47 PM, Neelesh Gupta wrote:
> >The patch exposes the available i2c busses on the PowerNV platform
> >to the kernel and implements the bus driver to support i2c and
> >smbus commands.
> >The driver uses the platform device infrastructure to probe the busses
> >on the platform and registers them with the i2c driver framework.
> >
> >Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> >Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >---
>=20
> Hi Wolfram,
>=20
> Did you get the chance to look at it?
> The patch addresses the comments and discussions on v1.

I think there are now 3 drivers in my queue which are not fully I2C
compatible but more supporting the very minimum to, say, read an eeprom.
I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
think about ways how to communicate deficiencies like "only 255 byte" or
"only WRRD messages" to users of that I2C controller. This is most
likely not happening before 3.19. But assistance is very welcome.


--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcyH7AAoJEBQN5MwUoCm28PsQAJeHC2R2xxVwK5huDYWpGuce
KOEXq8iaNShYVB3KS7q1ZYfE7lhy8nQiEW9OsHnL9MWkMfmTUibyFl+G77mffx1a
YOsDwznte2O3oS0vod9n4d7qDxcDarYVu3wb5K8IpGRZYZn+62BKTjfNtRWYuKnK
6R7aLaytUmy/lLBry3W1DtTwpww2jtQGmZPaCkcsZhOyr8m1CdBggG1CwDMGER7O
hGcNfiyRVdJJN9rQlGv2NVnHb5N2bbQRh3zczrQ5Fu36uUq0Kcna2xhs+Jh9W+3C
X0S7hZViGS24ubvBEgvhVZFBIGSpm47HMS8UgquN+5iWGVOT6FBlyY/rj5GlwA5S
8lSyze7V3kysx7umXi18Jpcw2W6ZzF4kNRHSAW1ExilfVXAAujuDdLkl02WrAgAx
vY9Fw5WB5Jh4Q+NFusG34V8peLX9HkvHBZJ6ySpgK+aHS1KVGQBqfK9mNGV30lHe
svF0K7rQyOEHux3bfrJPf4jp80RPMWdJSFRNwx7f3Se7Crh1leW3qq4Udc40VbZp
0BU7iTU4A9VDhrzsfa5zAopD7HkSE1WgoePp+9MWnqR00ZHpMtFL+ozrJF9RmdVy
m4dqORjrIs9lInXyTyfz1z43qH6Z90aJPtMtVUXb6VE8SEvJQUmwcY33gq1W+uD2
PhN9KB6p0sv+tAgr86ZF
=c4kk
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
