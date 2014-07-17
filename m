Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62F2C1A01B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 01:09:48 +1000 (EST)
Date: Thu, 17 Jul 2014 16:06:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <20140717150657.GY17528@sirena.org.uk>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1405606399-26608-3-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8c7vHYlrYOebzgj6"
In-Reply-To: <1405606399-26608-3-git-send-email-tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4 2/6] ASoC: mxs-saif: fix mixed use of public and
 provider clk API
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>,
 Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>,
 Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
 Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kevin Hilman <khilman@deeprootsystems.com>,
 linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com,
 Viresh Kumar <viresh.linux@gmail.com>, David Brown <davidb@codeaurora.org>,
 Anatolij Gustschin <agust@denx.de>, Dinh Nguyen <dinguyen@altera.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 spear-devel@list.st.com, Barry Song <baohua@kernel.org>,
 linux-samsung-soc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>,
 Paul Walmsley <paul@pwsan.com>, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 rabin@rab.in, Bryan Huntsman <bryanh@codeaurora.org>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>,
 =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, linux-media@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8c7vHYlrYOebzgj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 04:13:15PM +0200, Tomeu Vizoso wrote:
> In preparation to changing the clk provider API to use struct clk_core instead
> of struct clk.

Acked-by: Mark Brown <broonie@linaro.org>

--8c7vHYlrYOebzgj6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx+aOAAoJELSic+t+oim9kbYP/1XSKsTieBgyUHwsZVX4t8n8
RCddHvCUUKM1bGm4/zJcI3EcCy6vjvbt3QkgHSv6JD6ot0jyRo9mzoWEZiUz9lDn
D8JSITKut5tP1Th1bi+yla0Zm2wf56JModA9CBUT0B/BnOkqxgpTlIua5JmkWV6m
x+8e98J/rY68uX69MD2RBhCEMfx8UkHlQ3/nWpFUigsHAOogELhIV+ChFSuVq070
3qbLOzM9Hvbf8clKA0K2c1elyHlG6it+gtSk+6cQs3KH2YU23oi4Yd4b++mGxtsa
MHVca5khElB8RM06cEsacgpB6QDj5ya17QBnEwZa2Y/FT15mKNCHKCDqWHyh8YEm
K3phLMwcpdk2hoDeCt2WCSPpCQmRj2xFxG9BG6M6LEM4eHTx1HWb+Hu5uJvi2qQY
XQi5+3bECfElzmZxgQjfJ867VKHefRiX1nabOE6qdoposm5GoUiga5VpiCYuDc13
9hsCMpEpSg++Y2G6l7cDlvPDaLnIgGAQ2jLFn/Utfb6BRZtHkQ5zP9jKDecWH7C8
I7uGjfwnxn7dRlof42mrkPHstNvWGX5hQfhcggQdIeCOiDRfW/Z9u0lZFRTH5h1R
mKldh7ssgHvYFoMSsBq2tVHZmqAXHHw19OnFQBB2ZPBKJPgsiU1OF1cJQ5i3QJRM
RF2NVRXsIgDlPYLdPWZE
=S67s
-----END PGP SIGNATURE-----

--8c7vHYlrYOebzgj6--
