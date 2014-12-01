Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F9531A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 04:22:01 +1100 (AEDT)
Date: Mon, 1 Dec 2014 18:21:47 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Danielle Costantino <danielle.costantino@gmail.com>
Subject: Re: [PATCH] i2c: mpc: add register documentation to Freescale I2C
 driver
Message-ID: <20141201172147.GB3212@katana>
References: <547A4192.30102@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
In-Reply-To: <547A4192.30102@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2014 at 01:58:42PM -0800, Danielle Costantino wrote:
> i2c: mpc: add register documentation to Freescale I2C driver

This should be in one patch.

>=20
> return -ETIMEDOUT for all time-out error conditions

This should be in a seperate patch.

> and warn on arbitration lost.

And this should be dropped. "Arbitration lost" lost is not an error, it
is specified behaviour of I2C.

>      if (!(cmd_err & CSR_MCF)) {
> -        dev_dbg(i2c->dev, "unfinished\n");
> +        dev_warn(i2c->dev, "unfinished\n");

Are you sure this helps a regular user?


--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfKOrAAoJEBQN5MwUoCm2N4EP/013Uos6jsrhL1qYhLp6Hbh/
VxEd3nWOcqyNebBV8s/SJ/5nTBmboQnhF3by3wC5t7fl7vBOPnoMiHfYSRALu2cy
bsZ9LBbeiWy2HB4V49e/x27Ln2u8CDky8Bzn2FLpHbw3haqPwtWYvhWIX2hacIkN
iUlAqNPn5zVHOB+E9Z7+3J9Zx6H0VdgY4kRmmOmxuScRfuSEVyuEpTXMZTo09LuW
DR5qLJw3yvBnHtLSxZXHMnD2eGtgz/OqgkHTjOzgz/VVWrly12n7c/yezCZ/djVe
++nZHtGZ95vUeTIzt9cfzApgD8OZZFuPK/V/k8I6OfOj4eqdAqLMfStPwxLD3T0q
lXRIsPhXyyvimsKYCDl/TUgDRRIDwoBGd3oD7bp94HnhKgObvTnXjvvGzjIgK0cm
Pi+UK/HlAW5Zvmf08oKAwKoEoocEMESjtd3LPDs1jOcaSa0F1YPDBZqXWcFumswd
v9e2sDLw0Y+0GaMyxd3nbfWlDMderuts7WDAEXob06nZJvJSMhjaFL9g8Y1NarCi
EA6naTXZNnRJQ5auUhykG47Fv2oomaK9XuUhxHTtUY7J01cjrRy0TYMjmHmwz8c1
uz1tD34/n4X7KXK+RfpvknIT+/P0mprAEM+xPRIFOYzfU8rAAfeFwI0Z7RU71bgw
7ctwVwel62p0mm18gK8a
=sWnx
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
