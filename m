Return-Path: <ldewangan@nvidia.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Q496nXFzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 18:56:25 +1000 (AEST)
Message-ID: <57AAE731.8090603@nvidia.com>
Date: Wed, 10 Aug 2016 14:04:57 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa-dev@sang-engineering.com>, <linux-kernel@vger.kernel.org>
CC: <linux-i2c@vger.kernel.org>, Jean Delvare <jdelvare@suse.com>, "Wolfram
 Sang" <wsa@the-dreams.de>, Ludovic Desroches <ludovic.desroches@atmel.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason
 <jonmason@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>,
 "Brian Norris" <computersforpeace@gmail.com>, Gregory Fong
 <gregory.0xf0@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 =?ISO-8859-1?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Jochen
 Friedrich <jochen@scram.de>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman
 <khilman@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <kernel@pengutronix.de>, Kukjin Kim
 <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Seth
 Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>,
 Joachim Eastwood <manabian@gmail.com>, Carlo Caione <carlo@caione.org>,
 Alessandro Rubini <rubini@unipv.it>, Linus Walleij
 <linus.walleij@linaro.org>, Peter Korsgaard <jacmet@sunsite.dk>, "Tony
 Lindgren" <tony@atomide.com>, Vladimir Zapolskiy <vz@mleia.com>, "Sylvain
 Lemieux" <slemieux.tyco@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "Heiko
 Stuebner" <heiko@sntech.de>, Barry Song <baohua@kernel.org>, Patrice Chotard
 <patrice.chotard@st.com>, Stephen Warren <swarren@wwwdotorg.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Tony Prisk
 <linux@prisktech.co.nz>, <linux-arm-kernel@lists.infradead.org>,
 <adi-buildroot-devel@lists.sourceforge.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
 <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <kernel@stlinux.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tuesday 09 August 2016 05:06 PM, Wolfram Sang wrote:
> The core will do this for us now.
>
For i2c-tegra.c

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
