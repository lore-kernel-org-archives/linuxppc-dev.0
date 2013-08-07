Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ED80D2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 17:31:55 +1000 (EST)
Message-ID: <5201F7A7.90906@pengutronix.de>
Date: Wed, 07 Aug 2013 09:30:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 11/31] net: can: mscan: improve clock API use
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-12-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-12-git-send-email-gsi@denx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="A2uj2ixBURCwPXa6NEucXJr0Ud3SHHGlD"
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>,
 Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A2uj2ixBURCwPXa6NEucXJr0Ud3SHHGlD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/06/2013 10:43 PM, Gerhard Sittig wrote:
> the .get_clock() callback is run from probe() and might allocate
> resources, introduce a .put_clock() callback that is run from remove()
> to undo any allocation activities

AFAICS With this patch put_clock() is still a no-op, is there a patch
which adds some code there? If not, please remove.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--A2uj2ixBURCwPXa6NEucXJr0Ud3SHHGlD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIB96cACgkQjTAFq1RaXHNk/gCglYUsk67DfJ+JzFWnFUHnHrvh
sh4AmwRY47JqnOjkR/uoACTAHi7ZzcpG
=XRxu
-----END PGP SIGNATURE-----

--A2uj2ixBURCwPXa6NEucXJr0Ud3SHHGlD--
