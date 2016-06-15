Return-Path: <vinod.koul@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rVCVZ30lRzDqjS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 03:02:13 +1000 (AEST)
Date: Wed, 15 Jun 2016 22:38:28 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Leo Li <leoli@freescale.com>, Zhang Wei <zw@zh-kernel.org>,
 Barry Song <baohua@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Alexandre Courbot <gnurou@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, dmaengine@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 8/8] dmaengine: Remove site specific OOM error messages
 on kzalloc
Message-ID: <20160615170828.GD16910@localhost>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
 <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 08, 2016 at 02:12:27PM +0200, Linus Walleij wrote:
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

Yes that should be case with mine too :)

I think adding a coccinelle script and doing this treewise might be great

Thanks
-- 
~Vinod
