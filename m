Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B2D5514008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 06:43:46 +1000 (EST)
Date: Mon, 14 Apr 2014 21:43:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140414204331.GE25182@sirena.org.uk>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <12898efab7a5907e6ed1c438a486692f59ef9d8b.1396432924.git.Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TXtjXAp+Y+VkYOQB"
In-Reply-To: <12898efab7a5907e6ed1c438a486692f59ef9d8b.1396432924.git.Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_sai: Add clock controls for SAI
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net,
 galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TXtjXAp+Y+VkYOQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2014 at 06:10:19PM +0800, Nicolin Chen wrote:

> -- clock-names : Must include the "sai" entry.
> +- clock-names : Must include the "bus" for register access and "mclk1" "mclk2"
> +  "mclk3" for bit clock and frame clock providing.

This breaks compatibilty with old DTs - it just removes the "sai" name.
It's OK to deprecate the "sai" clock name but you need to keep support
for DTs that only specify that, there's no code for that left in the
driver.

--TXtjXAp+Y+VkYOQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTEhwAAoJELSic+t+oim9Mj0QAIwQBL/SGdZ+n6vV3Z5XflLP
KzUVEG4ODRrVYCLwZIcYLz6wQyqAEq/KcT+gZkB3hysZ0xSm+WzF8Dmpt5BUEIhr
VaQvN/CzlliLwQvCYWPI0U6tQiAY76eI7TEMOaqt2qqU/R0uIAVO+KdqWyurJ31X
3bhgUznDpPo6sVaxf5ngAM4dgxmHFWR+UsDFOzV7EzGbkvllT8mWya7mPPT+Iyod
YD204C0qsU9KKSrPJ0MUr/u3xZdURiHCBgHlVXP+KNn+8Du8q0fuYlnKa7daecPz
y/8q5tYFFUDjhQtjdtZoBHSp7/rvp4JiY0LtC3YuVo12EDHMipVzd1lZUDan2O1o
vFcl2GZ8iJYJMGzsLZtVpHF8vId9X5wt34FOSxt1G0DVwzHuEGeHhovE0jLUDRLr
y6JSL8VgULXGm88qmn+orOAqBlOj82sK8gdaP8jGaxC8qNhcXvbZiVRfZ0bgR4pl
reOocP9N+rx5oU9kUzDHM1lnl23Nywy5+mqxcpuknZU0uGTRFRMQuOV6xxLYSF/e
d4IziBZ0KTeoKp7dD5i5XbGfR5zlSfFT8BI5OOTOX5GtBg3Zxo95thk3bBG72zWs
D70sxZ9T3uzYLaTC65KkGxF+a3PX7eIcB14EzsqPc8js4L4Bjpz/nioyj9gL9kSt
Rx4C13U/4otoTh6EcCMy
=NkVo
-----END PGP SIGNATURE-----

--TXtjXAp+Y+VkYOQB--
