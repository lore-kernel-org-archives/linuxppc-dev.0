Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F369067BE2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 22:37:14 +1100 (EST)
Date: Wed, 1 Nov 2006 14:37:04 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: [PATCH/RFC] FS_ENET: Removed MII bitbang check for TA
Message-ID: <20061101143704.3c8c47cb@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0611011317280.848@host32.eke.fi>
References: <Pine.LNX.4.64.0611011317280.848@host32.eke.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_SoVTtQDv9aaQ8Ddj5+Rn6LI;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_SoVTtQDv9aaQ8Ddj5+Rn6LI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Nov 2006 13:22:17 +0200 (EET)
Kalle Pokki wrote:

> The PHY abstraction layer expects to receive 0xffff when
> reading PHY registers if there is no PHY at that address. The
> all-ones condition is guaranteed by the pull-up in the MDIO line, so
> there is no need to check for the TA bits.
>=20
> With this, the PHY layer is able to probe the MDIO bus as it expects.
> This also removes one board dependency from the fs_enet driver, as
> there is no need to set the phy_mask bits anymore.
>=20
> Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>

At the first sight this it OK.

I'll give it a try, prolly add some bits and forward along with the other=20
fs_enet stuff residing in todo.=20

Thanks,
-Vitaly

--Sig_SoVTtQDv9aaQ8Ddj5+Rn6LI
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFSIbhuOg9JvQhSEsRAt6OAJoCegDU8JYr9VEkP7z7Swgwkzl4EgCeNKxP
74B/rhv7aot6N1H3YnFfUqw=
=A/eI
-----END PGP SIGNATURE-----

--Sig_SoVTtQDv9aaQ8Ddj5+Rn6LI--
