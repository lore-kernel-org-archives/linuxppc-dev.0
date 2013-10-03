Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 86D992C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 01:58:27 +1000 (EST)
Date: Thu, 3 Oct 2013 16:58:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20131003155816.GU27287@sirena.org.uk>
References: <1380773722-1295-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dBMBt2YGaTHbdllf"
In-Reply-To: <1380773722-1295-1-git-send-email-linux@roeck-us.net>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix irq_of_parse_and_map() return value
 check
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>,
 Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dBMBt2YGaTHbdllf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2013 at 09:15:22PM -0700, Guenter Roeck wrote:
> irq_of_parse_and_map() returns 0 on error, not NO_IRQ.

Applied, thanks.

--dBMBt2YGaTHbdllf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTZQVAAoJELSic+t+oim9JlwP/0Ala1E0M65Sn7xS/CORBpuf
/602EdUaXZGQW2x4c+WSs8q8TGjiiK+UsJiXTTgFYUsKtJnw0XRjQ3OxuO1GL6TQ
atp0R4X4mWchwhO3by8k2lonx2aO5pZdoFz4jHBBDJn7dYyjJswX3y5yaZJGYCNM
7KoV2+xv3LiKcFui3gRO7fBVZr11ptmZ1kJ+w4AGfpinFpYRmxu3JCOuLU7W8pHL
Aqi8x4aFUkeizcR7h+v6942DgWWNApkIveNavLWTQzwhtAE+wl7+UT2UUFZ2/QEs
4vwKKm0N15hr62XRh4IcT+sCSQJPppjH5BHfJnMJZBKi4elk3BEYAT8aRJnq1YW3
JTxEan2OlZ/o3XtaVR4yFhNUWRzF9DbNoIzH+AgCLI88xbAvKSt3ojVU9H0Q3A8R
GANlsuDUw2ecvrfvPY+t9UdH9HEi9ucBmD9fWEifgP200DTx1t5Nuuy/9Y6pokYv
k/bhm1gVQPc5Yuo+BAveyAFIFbnHsjs0M23vprDF4N6F/zUNKkBaa3cZrr46X+Kk
fXOY7B7jZ7vQp3rtQGDHJIHNtNyc5QknK9/3yd+d6Hu4yO0Z1k2ar527eMeXwBYH
g2BZEo5jM9z8B8WHesakmzt9GCA8stbOYhdAbuDyk6NmZQu39AnQbUmFATvZ+F+C
G/NLvvg80V2bikvN5JLU
=UWBo
-----END PGP SIGNATURE-----

--dBMBt2YGaTHbdllf--
