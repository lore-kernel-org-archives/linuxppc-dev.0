Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420Gpw3pR2zDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 04:04:07 +1000 (AEST)
Date: Tue, 28 Aug 2018 19:03:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
 Olivier Moysan <olivier.moysan@st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2] ASoC: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180828180335.GG2414@sirena.org.uk>
References: <20180828154433.5693-1-robh@kernel.org>
 <20180828154433.5693-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8TMLq6GPUuN4DysL"
In-Reply-To: <20180828154433.5693-2-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8TMLq6GPUuN4DysL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 28, 2018 at 10:44:28AM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Please don't send new patches in reply to existing threads, it makes it
harder to follow what the current versions of things are.

--8TMLq6GPUuN4DysL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFjnMACgkQJNaLcl1U
h9BnyQf/cdl8XKMk/yZXqmTYdTxNvRvHBV00zFsFCpmSB2fxFPQl9u0BC/JZSMSb
QJ2GfCxUgp1/j2S8iDUSWGCZG6bq/turgrP2m+ZYZeTvA7wsVduGMBYEVqwurAxX
6XNPCGC2ZrvUV89j1fYc4jxXjTC0vPYWnK6M3sZCKqJKP4CTeRxFDyFdBtGlmHdZ
taXllc0H3Kpp8xU5P3zmlwBW4kErt8XwBb/yj3cN0pbJbXqwrOOUTIFXTf3XFg+x
xM3pTAUEZjyhDNQHg+C6yYv8rpf8oqAeu/v7WLj9q4UsQ0y7x3vfxYmlQe7Qt+5Z
BvxDzb2t7uzOrvhRrEhcRSRs5j+EIg==
=Bsjk
-----END PGP SIGNATURE-----

--8TMLq6GPUuN4DysL--
