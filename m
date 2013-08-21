Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D6FC52C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 05:48:23 +1000 (EST)
Date: Wed, 21 Aug 2013 20:48:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Anatolij Gustschin <agust@denx.de>
Message-ID: <20130821194817.GL26118@sirena.org.uk>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-2-git-send-email-gsi@denx.de>
 <20130821212258.2cbc969c@crub>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HL3CiL6n73+IAdG4"
In-Reply-To: <20130821212258.2cbc969c@crub>
Subject: Re: [PATCH v4 01/31] spi: mpc512x: cleanup clock API use
Cc: devicetree@vger.kernel.org, Gerhard Sittig <gsi@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--HL3CiL6n73+IAdG4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2013 at 09:22:58PM +0200, Anatolij Gustschin wrote:

> Mark, are you going to apply this patch? Or should I queue it
> in my mpc5xxx tree (I'd like to get your Acked-by then)?

Has this series settled down?  I'd been ignoring it since it was getting
so many and so frequent revisions.

--HL3CiL6n73+IAdG4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFRl9AAoJELSic+t+oim9XcgP/jrHPPLOFbwXqyqMPfTbnAMP
3nNQkIkVVXUYOrYkWRpzaffpBe3xCaTrqWNT8nU7oIirbnRS640cq2SoS3gIizLK
tiQatKsZEm51b6bHB04Nl37n34GQbKJaJs+0RHnN6/outFgpytdXwFzVNvPAqFd9
9ZND8DqyxPFUxF2cfpHNFZi5hFcVLHj0ckXb5xHbCxCrZEOhx3hKTzHOpWtHKB+q
9ITizGaKgSGzejhBfyD27cdmNkRctsfaK1w3x1DXOGsMliEp+nLRjolnF3PZ8FvB
2pj6RndEAi6Pu4160ZWiUCs6Rpj7WtDhBUexZaWkurCXVn5BfoHG8/xiaTFh0z44
i9PxmmZh2jHrgUmWF1zciTTfp7xON4smwLKOGN8FOCyGvAAkYXfeBjX2OWrOxwqv
75oanq5lithbPrRsjaMchud9h5XgQBh6Ou6ytrXj/JDrBI3bh/Cvm9p5kRZZe51X
nMk8ydspkP/3xjdo876bBnJhDW+Bh1IPfVFRCw60cnUVFwKkZ8oVHHJr/YEW5c/K
de3dWGuUarmAOBADDdIATmkhs+VUnS54sTYEiem6zr04yYqIZlFGR5VXfka2rhpB
Vuha3ARk9WUtzCIrDdqqyWaiAVq0EG2b9NlyDwSzsYH4mgexr3fRqHP7nPthfCC5
pygEw+vx4qK+AFhTS/ZX
=r6Yz
-----END PGP SIGNATURE-----

--HL3CiL6n73+IAdG4--
