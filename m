Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0108.outbound.protection.outlook.com [157.56.111.108])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 668A21A006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 08:05:20 +1000 (EST)
Message-ID: <1411682696.13320.207.camel@snotra.buserror.net>
Subject: Re: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
From: Scott Wood <scottwood@freescale.com>
To: Mike Turquette <mturquette@linaro.org>
Date: Thu, 25 Sep 2014 17:04:56 -0500
In-Reply-To: <20140925213959.19023.80648@quantum>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
 <20140925213959.19023.80648@quantum>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-25 at 14:39 -0700, Mike Turquette wrote:
> Quoting Jingchang Lu (2014-09-22 23:46:46)
> > +CLK_OF_DECLARE(qoriq_core_pll_v1, "fsl,qoriq-core-pll-1.0", core_pll_init);
> > +CLK_OF_DECLARE(qoriq_core_pll_v2, "fsl,qoriq-core-pll-2.0", core_pll_init);
> > +CLK_OF_DECLARE(qoriq_core_mux_v1, "fsl,qoriq-core-mux-1.0", core_mux_init);
> > +CLK_OF_DECLARE(qoriq_core_mux_v2, "fsl,qoriq-core-mux-2.0", core_mux_init);
> 
> Is there binding documentation for these compatibles?

Documentation/devicetree/bindings/clock/qoriq-clock.txt

-Scott
