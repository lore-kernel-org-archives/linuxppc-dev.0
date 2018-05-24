Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40sL6F60NrzF0TM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 06:08:03 +1000 (AEST)
Date: Thu, 24 May 2018 22:07:59 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: opal: don't check number of messages in the
 driver
Message-ID: <20180524200759.bmcati5h3fzobtur@ninjato>
References: <20180520065035.7920-1-wsa@the-dreams.de>
 <20180520065035.7920-3-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z2owrkxff3iiku6g"
In-Reply-To: <20180520065035.7920-3-wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--z2owrkxff3iiku6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 20, 2018 at 08:50:34AM +0200, Wolfram Sang wrote:
> Since commit 1eace8344c02 ("i2c: add param sanity check to
> i2c_transfer()") and b7f625840267 ("i2c: add quirk checks to core"), the
> I2C core does this check now. We can remove it here.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--z2owrkxff3iiku6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsHG58ACgkQFA3kzBSg
KbakTw/43FO4Yi3zQylLuRTKH8S3IjK5+LMiYiMmYOe4MvFy4GEsjxyrCtA1xzIw
KEZgbjc34sWfn6YmoFuDVSA8i2uZ+pXfW2vvEhxyYC121Lg+pjwxBRr41RbP05ZZ
r4uyv6gmkwn3GF9qKDEuToWTIuUDRcm/Js6gKt+BThlnno7NIUfn4YDVUgHowyPH
53e1A4aL4GxG0j2WU+97l2oMP8GoWeo9uc1WhA5LZy3R34UkUbErzswkQD+z/95/
FC/TZ3JpIhalVS4LeHaEwmg8oCsCCmkujOCp2RJEUHzsZ99j+MqEDA+fwmO+nzLb
f7cAjIjOCFOYN5MEIKobbjDoT3nkQZ3qSAo+sx9Li8ZiIFecW4WsQUypA0QX+I7p
gBlMZodVnuETAMNHaChnnuEMIsAk5wwFxTGWTYUdCheExaQI93+n/PjkpPH2anw4
2dThwuJqLjDXTgMq7cSbuinxwz6wBobn3gK9kZXU2LDZ7xCWVOe7KNyju6cSt+Qx
UJe5E48gtHKv/oneKqNN9PFchN8T4y9x0ZXjhSHu9PJQ8MCz28TAFrDSJ0unXeCw
4UxlR39/BrT242qG2Qfs5JvnQvVgsHL6lVYhmHWxIKhqYyfYV1mZmR+mx7+l3ZhR
ZJRcIWgA/VHR73WZ3nLcFpus0vehNwWRbVMLFUt4buupvsUp0A==
=jjt2
-----END PGP SIGNATURE-----

--z2owrkxff3iiku6g--
