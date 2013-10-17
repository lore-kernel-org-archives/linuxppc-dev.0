Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3ECA32C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 20:41:02 +1100 (EST)
Date: Thu, 17 Oct 2013 10:40:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20131017094054.GJ2443@sirena.org.uk>
References: <1380773722-1295-1-git-send-email-linux@roeck-us.net>
 <20131003155816.GU27287@sirena.org.uk>
 <525F4421.3090404@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="agVz1gqRg0BwYviO"
In-Reply-To: <525F4421.3090404@roeck-us.net>
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


--agVz1gqRg0BwYviO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2013 at 06:57:53PM -0700, Guenter Roeck wrote:

> do you plan to send this patch upstream anytime soon ?

It'll go next time I send stuff if it hasn't already.

--agVz1gqRg0BwYviO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX7CjAAoJELSic+t+oim9ZvMP/iguM/JmDhW+NeRgbccLUquR
tGkh7Sr4EfaYAM80Z2jcRX2Z+WKB9zGZsNvT/y3sEM6UJnyyoY0Nhzfn0ZirHorJ
sNjvufySJvJWl4UwlPGekNo42Jp+8o0EFXzhDe5fThC2utJlT9F/Dtzqsh6veaCY
zz4LQkImJNjfx5OfjS1mfn4fqZnt/q/q1TJmFcwaJiU+2rYzVu0VWZqsIjFDxGI7
QD9jLRt1Y7IvZOFT/fbheR8B8pmx+5g/dh0ymdOVPJbLo2NmNPCMGimz7723R/Qh
QPBXIisyFkLJq9GjBXCYRlt4/fk8cIoynObJ2ihBOEXFGLcJ3qgUjmWaSd+hWumr
bHjLrgSB83mHU/yvBtcLsH7MUziVyyfg7JtvuenwAVVPfSha2N/3/Tz/vvQX/Rha
GC47KdnrH8+a69S0E/c6C5b9qK+BCY/lBGnWp08PR2r2NHc5Ob43QtsRBjCSK48v
sRbq+yXjV4BmWE1FHTvAFx2UbCQZCgkd/keTcQDDqcXClFvH31A4GY0VAyZXscqt
T5Xt23IAsSVf1M+fS728YBpPQ47DaLOZqvGqHxEBkk9SqjLUXpfCmxuWy1HZJKWy
e//AYo7jyi8845cCL97+vPG+kN/hO0VUpoj4sl/wgl2BwT4qGLW1u8OLwUCBixI8
bMfvi1xQmhyTzgI//y9M
=gIzk
-----END PGP SIGNATURE-----

--agVz1gqRg0BwYviO--
