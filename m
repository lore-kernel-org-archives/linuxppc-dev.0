Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 967B81A0D9D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 09:48:46 +1100 (AEDT)
Date: Thu, 4 Dec 2014 22:48:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiada Wang <jiada_wang@mentor.com>
Message-ID: <20141204224829.GJ11764@sirena.org.uk>
References: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
 <1417499707-3125-3-git-send-email-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
In-Reply-To: <1417499707-3125-3-git-send-email-jiada_wang@mentor.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_ssi: use platform_get_irq instead of
 irq_of_parse_and_map
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, arnd@arndb.de,
 lgirdwood@gmail.com, tiwai@suse.de, linuxppc-dev@lists.ozlabs.org,
 timur@tabi.org, linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
 Li.Xiubo@freescale.com, mpa@pengutronix.de, festevam@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 02, 2014 at 02:55:07PM +0900, Jiada Wang wrote:
> Use platform_get_irq as no mapping needs to be done.
> By using platform_get_irq, driver can avoid to free IRQ manually
> when SSI driver exits.

Fabio sent a version of this before yours so I applied his, I think the
code is the same.

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgOS8AAoJECTWi3JdVIfQ3M8H+wSnaBd8ZqS5scwBA4+nuvOt
Nav08xc13F8K+uyfeIXk0a765aXfhLaMsJXesj8hotgxVb3SEoXOc/EMjvYEA8ol
/+ZGTQISUibE1IA5c5N+eN7duVGEC0H5hM5DwL5VSfM9tNHFKWz1B0yrJwYOj7i0
9wy9oZhymbTYb5jTtlIeRfkg0CUUM/LS8Um7PTjvsfxZEWodYDnZdSeGaWfimHV7
2HeR1XqXTWx/2zTCnZx4pPWlyDNPkEjim7sN31jOMazUDzkxJ3XfhiCPARuDivnF
Lskgc1qbUSnJm93S3rbgA8yZhCn8EQ+ybQu3Krk5Ix60fxWuJVG4N8a0yZa+Iyw=
=a+Pl
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--
