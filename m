Return-Path: <chris@void.printf.net>
Received: from void.printf.net (void.printf.net [89.145.121.20])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA8BE1400B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 03:26:42 +1000 (EST)
From: Chris Ball <chris@printf.net>
To: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <535E84FB.4080305@wwwdotorg.org>
Date: Mon, 28 Apr 2014 17:52:00 +0100
In-Reply-To: <535E84FB.4080305@wwwdotorg.org> (Stephen Warren's message of
 "Mon, 28 Apr 2014 10:42:35 -0600")
Message-ID: <86mwf5tn0v.fsf@void.printf.net>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-doc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, spear-devel@list.st.com,
 Rob Herring <robh+dt@kernel.org>, Ben Dooks <ben-linux@fluff.org>,
 linux-tegra@vger.kernel.org, Shawn Guo <shawn.guo@freescale.com>,
 Barry Song <baohua@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-mmc@vger.kernel.org, Viresh Kumar <viresh.linux@gmail.com>,
 Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Apr 28 2014, Stephen Warren wrote:
> The series,
> Tested-by: Stephen Warren <swarren@nvidia.com>
>
> (On an NVIDIA Tegra "Jetson TK1" board, with the patches applied on top
> of next-20140428, also with Andrew Bresticker's Tegra SDHCI patches
> "mmc: tegra: disable UHS modes" and "mmc: tegra: fix reporting of base
> clock frequency" applied)

Thanks very much Stephen, Russell for the series, and Ulf.

This seems like a good time to merge to mmc-next and call for testing
in linux-next -- I'm happy to merge a v2 PR when ready.

- Chris.
-- 
Chris Ball   <http://printf.net/>
