Return-Path: <jason@lakedaemon.net>
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3FFE1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 02:05:35 +1000 (EST)
Date: Tue, 9 Sep 2014 12:05:16 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 3/5] ARM: mvebu: Change vendor prefix for Intersil
 Corporation to isil
Message-ID: <20140909160516.GQ30828@titan.lakedaemon.net>
References: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
 <1410167960-554-4-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410167960-554-4-git-send-email-p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Alessandro Zummo <a.zummo@towertech.it>, Russell King <linux@arm.linux.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 08, 2014 at 11:19:18AM +0200, Philipp Zabel wrote:
> Currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. At this point, changing the vendor
> symbol to the most often used variant, which is equal to the
> NASDAQ symbol, isil, should not hurt.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 2 +-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts | 2 +-
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied to mvebu/dt

thx,

Jason.
