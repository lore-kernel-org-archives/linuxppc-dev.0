Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by ozlabs.org (Postfix) with ESMTP id 6E5E7B6FDF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 18:21:07 +1000 (EST)
Date: Mon, 16 Apr 2012 09:15:32 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
Message-ID: <20120416081532.GA3238@opensource.wolfsonmicro.com>
References: <1334483574-3997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdZ8yH1ZSG-nQ9dLm0TipHS-jZDuxwqohUC=LGH9V-5q4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <CACRpkdZ8yH1ZSG-nQ9dLm0TipHS-jZDuxwqohUC=LGH9V-5q4w@mail.gmail.com>
Cc: linux-arch@vger.kernel.org, Grant Likely <grant@secretlab.ca>,
 linux-ia64@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>,
 Chris Zankel <chris@zankel.net>, microblaze-uclinux@itee.uq.edu.au,
 linux@lists.openrisc.net, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2012 at 09:21:58AM +0200, Linus Walleij wrote:

> This looks good but I think we need to page the alpha, ia64, m68k, microblaze,
> openrisc etc subarch maintainers on this patch so they have their say.

That's why I CCed linux-arch, to get all the architecture maintainers
included.  vger would get upset if I CCed everyone individually.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPi9UcAAoJEBus8iNuMP3dwnAP/2dv6D/vCKCnVow62FY69z5M
6VwwMtgSOYJ68+/oGt/n45g/bTZoF2+eZAgN9Tljjdn/aVWj7YxWSvrNMnSIk3sP
Lr0QYsbTaD+TNA1I39DUrENH/hA0sm4XDIxlE1swMs3stcqt+SrNT8i9bcZTG9bV
71Y2Dsrwg4uyU2Sq0szL6S0fTgSe5c8bz9LlVInrSpiSoqkUB+D0UAyRQBHTlYnl
GqmpyVmh938NjZT8tDeCtQ9VhTabsxtzP359JsshSbXpSYrsV/epKY83b1OzTPFw
tG8gPANoy2N6CSNvdC60y6ZXF+WtIZsooQXDWK/rd2pDQgShQxkXknDHYvnZC2L6
W2a4abHw99U9kT7pUzpWSKhkcFYbwEhbWD54beMN5UwEao1YhLmL0OOxs9hU3n7X
96xZL6Pk/4Gv8qFtuJndHEwY0kt0VAujFLiz01ZUbrzZp8Ea30yQnF2ZoZTCVsWx
GvG99k6EIfke/Jx+/iwU1xuTZUXqas/2jZ8gHpbvD9Njd6FqToJzm8lE2FDxfUip
+KnOSqrkPf4X5v/ycWmJpzcYJ1RgwXfRAG5UbcpWQqGEwTyaXmzqkmIoe4vMbidl
yHSF9Va4ptGrMrETzdNAe2NEB1GTJAdrIpzxAPV0a2xBMN/E9vje2BjCkfp3iMqf
JWhB4suNDfmlpLGNPLm4
=BiWD
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
