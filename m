Return-Path: <lee.jones@linaro.org>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQTkz1Mm5zDq68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 01:30:02 +1000 (AEST)
Received: by mail-wm0-x229.google.com with SMTP id v199so112769031wmv.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 08:30:02 -0700 (PDT)
Date: Thu, 9 Jun 2016 16:30:34 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
 Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Leo Li <leoli@freescale.com>, Zhang Wei <zw@zh-kernel.org>,
 Barry Song <baohua@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Alexandre Courbot <gnurou@gmail.com>, dmaengine@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 8/8] dmaengine: Remove site specific OOM error messages
 on kzalloc
Message-ID: <20160609153034.GB5438@dell>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
 <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 08 Jun 2016, Linus Walleij wrote:

> On Tue, Jun 7, 2016 at 7:38 PM, Peter Griffin <peter.griffin@linaro.org> wrote:
> 
> > If kzalloc() fails it will issue it's own error message including
> > a dump_stack(). So remove the site specific error messages.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> A few subsystems may use a cleanup like this...
> I wonder how many unnecessary prints I've introduced
> myself :P

Wolfram did some analysis on this a while back.  IIRC he also
presented on his findings at ELC(?).
 
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
