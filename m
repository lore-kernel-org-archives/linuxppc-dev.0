Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 41xgzl1MpmzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 22:47:45 +1000 (AEST)
Date: Fri, 24 Aug 2018 14:47:37 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] macintosh: therm_windtunnel: drop using attach_adapter
Message-ID: <20180824124737.pdiktpor5ofpfo45@ninjato>
References: <20180821150240.19964-1-wsa@the-dreams.de>
 <20180821150240.19964-2-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="exskspteuohzfyut"
In-Reply-To: <20180821150240.19964-2-wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--exskspteuohzfyut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 05:02:39PM +0200, Wolfram Sang wrote:
> As we now have deferred probing, we can use a custom mechanism and
> finally get rid of the legacy interface from the i2c core.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--exskspteuohzfyut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt//mUACgkQFA3kzBSg
KbZYGg//U81jqO+xJivJmJi18OYtguMoRFghC2VH4BjYdMP9yyy6JsXqr63AIRF4
IBkR4zmRtm5xU8IOL8LAHBIOHQ5blY1HvqXG7y4uV2X1L7vpSD7vneKR0noJg/OC
k2DFPyFdIahTkVvhYAbJLo/ypmpccWYP9ySkGIl7haLktoSGKkZJCT+lRl6qKRx+
Jw0aOykpHgVFt/Tg2WDcMwnM+jpQwZ0pGmzdZ69bQT4kH/bUJJDFa+fGHSzw0GOj
c6si5muNsw/Yj12IBRlXYJf7Xg8C7dZLkqqWeX7wYlvOSuAaTksJaZ2ZrNB22hiD
k5UsyNgONl6cfT2gvXdidVk5QPB5NkXgTLxejeLp9Lk8kD5jpqno+eOpD8xTVjQv
0POmu0fAkgla7Hmaq5xCj+8aXNUwogpInnUcE7R4/4tYs+nOcAYRdFMnTR/olHUP
LfEyYeX+0WX+04IVZY5BrxoyNJyRuxJuqQ1NggifYl9xPwMSSdSA0Ba6uvFh3G9F
HvpG/PYZmzHS3T7pmFVe25Jm0implMScwP7OrUcYeSMzOdz4+g7rEDVYGF+Jg9HP
oMLGrZRwnIg1ZPzRwVV7oOs73V03q3TSuJbN5W/aSb9vE4K9irhvL7+4JlwwaNfE
teacpRRlN3sboLv+k+jG23J4XcPXc/bjd4FIcdk6RRBKZTiuTWk=
=Qivk
-----END PGP SIGNATURE-----

--exskspteuohzfyut--
