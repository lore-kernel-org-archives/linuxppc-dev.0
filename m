Return-Path: <jacmet@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7swn0fqrzDqh5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:48:09 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id i138so2569125wmf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 04:48:08 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <peter@korsgaard.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,  linux-i2c@vger.kernel.org,  Jean Delvare
 <jdelvare@suse.com>,  Wolfram Sang <wsa@the-dreams.de>,  Ludovic Desroches
 <ludovic.desroches@atmel.com>,  Ray Jui <rjui@broadcom.com>,  Scott
 Branden <sbranden@broadcom.com>,  Jon Mason <jonmason@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,  Florian Fainelli
 <f.fainelli@gmail.com>,  Sonic Zhang <sonic.zhang@analog.com>,  Brian
 Norris <computersforpeace@gmail.com>,  Gregory Fong
 <gregory.0xf0@gmail.com>,  Michal Simek <michal.simek@xilinx.com>,
 =?utf-8?Q?S=C3=B6ren?= Brinkmann <soren.brinkmann@xilinx.com>,  Jochen
 Friedrich <jochen@scram.de>,  Sekhar Nori <nsekhar@ti.com>,  Kevin Hilman
 <khilman@kernel.org>,  Guenter Roeck <linux@roeck-us.net>,  Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,  Kukjin Kim
 <kgene@kernel.org>,  Krzysztof Kozlowski <k.kozlowski@samsung.com>,  Seth
 Heasley <seth.heasley@intel.com>,  Neil Horman <nhorman@tuxdriver.com>,
 Joachim Eastwood <manabian@gmail.com>,  Carlo Caione <carlo@caione.org>,
 Alessandro Rubini <rubini@unipv.it>,  Linus Walleij
 <linus.walleij@linaro.org>,  Peter Korsgaard <jacmet@sunsite.dk>,  Tony
 Lindgren <tony@atomide.com>,  Vladimir Zapolskiy <vz@mleia.com>,  Sylvain
 Lemieux <slemieux.tyco@gmail.com>,  Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Heiko Stuebner <heiko@sntech.de>,  Barry Song <baohua@kernel.org>,
 Patrice Chotard <patrice.chotard@st.com>,  Laxman Dewangan
 <ldewangan@nvidia.com>,  Stephen Warren <swarren@wwwdotorg.org>,  Thierry
 Reding <thierry.reding@gmail.com>,  Alexandre Courbot <gnurou@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,  Tony Prisk
 <linux@prisktech.co.nz>,  linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org,  linux-samsung-soc@vger.kernel.org,
 linux-amlogic@lists.infradead.org,  linux-omap@vger.kernel.org,
 linux-rockchip@lists.infradead.org,  kernel@stlinux.com,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Date: Tue, 09 Aug 2016 13:48:03 +0200
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
 (Wolfram Sang's message of "Tue, 9 Aug 2016 13:36:17 +0200")
Message-ID: <87vaza2mfg.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Wolfram" == Wolfram Sang <wsa-dev@sang-engineering.com> writes:

 > The core will do this for us now.
 > Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
 > ---
 >  drivers/i2c/busses/i2c-ocores.c         | 4 +---

For i2c-ocores.c:

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
