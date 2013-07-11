Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 782E22C0335
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 03:17:50 +1000 (EST)
Date: Thu, 11 Jul 2013 17:54:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20130711165401.GU24508@sirena.org.uk>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xku3GkZTJumTa1rO"
In-Reply-To: <1373453034-21618-1-git-send-email-b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Disable SSI in trigger() if RE/TE are both
 cleared
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xku3GkZTJumTa1rO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2013 at 06:43:54PM +0800, Nicolin Chen wrote:
> The code enabled SSIEN when triggered by SNDRV_PCM_TRIGGER_START,
> so move the disable code to SNDRV_PCM_TRIGGER_STOP for symmetric.

Applied, thanks.

--xku3GkZTJumTa1rO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3uMmAAoJELSic+t+oim9R/8P+wezuSYtszTrk7LS/wgBCP4z
0nSdKPu+TPZK9AB3w7jqHuz9H6IBdzak40+EYVvJyUQQJi0nwNIe0Uw/Gfdhb9oE
RJFHpOIhZegdP6NtUTqg9utmRUWBTvBVq23SICvZl6BOFDhwcl4ktUxUL3xRipz9
x2CXru+RU50Os/X2U8irJVa/YmHk3nSxzYkBXGIzOg3mggFI7WdPt36heNc2ZHYa
KoMq9wwb5cvqsA4sQ9dxw4qalXMsGN4NfnOaWeFNWfjv6yCkaAKb2rVsIcyq6YIw
4IUXbz7zaH5hPq7hbliPguMqlDtselZJaebObanbSKT8t8V1C8XhAQ0OMCnaWAn+
jQsj5yNnASn6EFHqMFXpGEVREsFERji5a5j9KpdZVQ7pDR95kn1khDPyMBw4iB2o
mmk+CasqW8P6AWoIWVcZtrLclGSwk+txF/3xaGGivW3opn4/OO3q1basmww8zY1D
EAb7ca7X5nMFnIP/DPbEgnTSE94tMjKXCJc2mhaYYzw9es0RCfXIpw9kPhvaf/5m
eHMmmHDoSEekeoB4lCw9NuvoE0MAB6zeuypOvc+pbgZHTKa2wBys9OH/mMq4jrfK
hyLvZOHjB0DIrmXV2fRi1LELp1WdKukkFlSZ8sGued9m/xD9JdzEVPTlBokNeJH5
VXC6LATsBPrTQpsAd+k+
=tfSg
-----END PGP SIGNATURE-----

--xku3GkZTJumTa1rO--
