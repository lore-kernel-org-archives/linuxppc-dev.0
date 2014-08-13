Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by lists.ozlabs.org (Postfix) with ESMTP id 45A941A0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 19:51:03 +1000 (EST)
Date: Wed, 13 Aug 2014 11:50:56 +0200
From: Boris BREZILLON <boris.brezillon@free-electrons.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v5 3/6] clk: Move all drivers to use internal API
Message-ID: <20140813115056.0bd5ead7@bbrezillon>
In-Reply-To: <1407333468-32180-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1407333468-32180-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>,
 Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
 Mike Turquette <mturquette@linaro.org>,
 Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
 Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com,
 Viresh Kumar <viresh.linux@gmail.com>, David Brown <davidb@codeaurora.org>,
 Anatolij Gustschin <agust@denx.de>, Dinh Nguyen <dinguyen@altera.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 spear-devel@list.st.com, Barry Song <baohua@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>,
 Paul Walmsley <paul@pwsan.com>, Peter De Schrijver <pdeschrijver@nvidia.com>,
 linux-kernel@vger.kernel.org, rabin@rab.in,
 Bryan Huntsman <bryanh@codeaurora.org>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>,
 =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, linux-media@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tomeu,

On Wed,  6 Aug 2014 15:57:48 +0200
Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:

> In preparation to change the public API to return a per-user clk structure,
> remove any usage of this public API from the clock implementations.
> 
> The reason for having this in a separate commit from the one that introduces
> the implementation of the new functions is to separate the changes generated
> with Coccinelle from the rest, and keep the patches' size reasonable.
> 

You can add my:

Tested-by: Boris Brezillon <boris.brezillon@free-electrons.com>

and

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

for the at91 part.

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
