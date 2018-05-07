Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fgDl3CyZzF1Q2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 21:21:43 +1000 (AEST)
Date: Mon, 7 May 2018 13:15:22 +0200
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Gilbert <benjamin.gilbert@coreos.com>,
 "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: wii_defconfig: Enable GPIO-related options
Message-ID: <20180507111522.GA32665@latitude>
References: <20180430134252.17345-1-j.neuschaefer@gmx.net>
 <20180430134252.17345-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
In-Reply-To: <20180430134252.17345-2-j.neuschaefer@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 03:42:47PM +0200, Jonathan Neusch=C3=A4fer wrote:
> Now that there's a GPIO driver for the Wii, let's enable the following
> drivers:
>=20
> - the GPIO driver itself
> - gpio-keys
> - gpio-poweroff
> - gpio-leds and a few LED triggers
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
[...]
> +CONFIG_LEDS_CLASS=3Dy
> +CONFIG_LEDS_GPIO=3Dy
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> +CONFIG_LEDS_TRIGGER_PANIC=3Dy

Oops, this doesn't work without first enabling CONFIG_NEW_LEDS and
CONFIG_LEDS_TRIGGERS. I'll send a v2.


Jonathan Neusch=C3=A4fer

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJa8DVDAAoJEAgwRJqO81/bhdsP/0so8ZngWoGwQUkLG5U4ZX78
8Cz8CvwiJPOPzuyRTGJkHytdYPG8pqAfC1A6wAnWN9zoqAdPO6FkOe//l7OecBLS
zq/cE+OAnzaZajG2mPjEgnavjZhjvy/HXhfJCA+LuvzRW87gpsddhX0V9ZMkFtWF
jSfkS0AsI+rIU9t0lMY68i5LjmqG9OEPcFhPKPpjqwS4Ji+KqZnFh+aYQRhE9l/c
x+tm9SqHivSgINpT9NkOKhfJIn/GnpsZVZqIbdFTA8PLuKS/CfA5SX9IwEIwn3ch
sfhJC6E9gq2as5OcQD3EqHLlLYXkfPFDfs2nWh7AuMod/w4KUBtnP7GV5P1JBEuu
xSeJv4UCvKM1zBvUiZ/4Kz0/2HAKMOJr8v8hueOmiGgjGKYJ3aD1EGtFwQHq5WkG
3u626YpbbJAK7BbTzbiYPXu4AFxotuCh1ZSSzMezSylBCq5FMCLfWjSrlDPUxuhV
UqKQohEXM4Fn+x3rGQMYfjWC8JQZWQBlFWbHw3rgcYMHDEDFJ2gJ/YVDozjFINKx
irv2DVaPSD7GHCpOilceXXiRgDfwTvdEmD8jziUL/gfEBOs/1OBfgR0/PJ9CL8Za
qhi4JTP3zEStCwk0+k2wXfJb7z4BnuP9KOa10noIlZ78HykIf4t4EEffIWwjRbSU
ymURcz6hJmEQtybJMz5Z
=bAkE
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
