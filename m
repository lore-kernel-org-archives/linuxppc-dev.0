Return-Path: <jason@lakedaemon.net>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC26E1A0F11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:13:54 +1000 (EST)
Date: Wed, 20 Aug 2014 08:16:43 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [RFC PATCH 0/6] Change vendor prefix for Intersil Corporation
Message-ID: <20140820121643.GU12769@titan.lakedaemon.net>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Alessandro Zummo <a.zummo@towertech.it>, Russell King <linux@arm.linux.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
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

Philipp,

On Wed, Aug 20, 2014 at 10:42:58AM +0200, Philipp Zabel wrote:
> Hi,
> 
> currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. I figure at this point it is still
> possible to change this to use "isil" everywhere without too
> much pain, but it might be preferred to keep the already
> documented "isl" prefix, even though it doesn't follow the
> convention to use the NASDAQ symbol where available.
> 
> The current users of the "isil" prefix are the following drivers
> and device trees, so we could just as well change those instead:
> 	arch/arm/boot/dts/tegra20-seaboard.dts
> 	arch/arm/boot/dts/tegra20-ventana.dts
> 	arch/arm/boot/dts/tegra30-cardhu.dtsi
> 	arch/powerpc/boot/dts/p1022rdk.dts
> 	drivers/staging/iio/light/isl29018.c
> 	drivers/staging/iio/light/isl29028.c
> 
> regards
> Philipp
> 
> Philipp Zabel (6):
>   of: Change vendor prefix for Intersil Corporation to isil
>   Documentation: Add isl1208 and isl12022 to trivial-devices list
>   ARM: mvebu: Change vendor prefix for Intersil Corporation to isil
>   powerpc/85xx: Change vendor prefix for Intersil Corporation to isil
>   rtc: rtc-isl12022: Change vendor prefix for Intersil Corporation to
>     isil
>   rtc: rtc-isl12057: Change vendor prefix for Intersil Corporation to
>     isil
> 
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 4 +++-
>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 2 +-
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts            | 2 +-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts            | 2 +-
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts            | 2 +-
>  arch/powerpc/boot/dts/ppa8548.dts                         | 2 +-
>  drivers/rtc/rtc-isl12022.c                                | 3 ++-
>  drivers/rtc/rtc-isl12057.c                                | 3 ++-
>  8 files changed, 12 insertions(+), 8 deletions(-)

This looks good overall.  My only nit is that I'd like to see the legacy
name(s) captured in the binding docs.

I'll take the Armada dts changes through mvebu/arm-soc after a few days.

thx,

Jason.
