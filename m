Return-Path: <htejun@gmail.com>
Received: from mail-qg0-x22f.google.com (mail-qg0-x22f.google.com
 [IPv6:2607:f8b0:400d:c04::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D90841A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 13:49:51 +1000 (AEST)
Received: by qgfi89 with SMTP id i89so58256893qgf.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 20:49:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 27 Apr 2015 23:49:46 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Kernel 4.1-rc1 build fails  on Sam460ex amcc 460ex powerpc
 Canyonlands
Message-ID: <20150428034946.GE2152@htj.duckdns.org>
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <553E16A0.704@candw.ms>
 <1430183545.7246.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430183545.7246.1.camel@ellerman.id.au>
Cc: andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Julian Margetson <runaway@candw.ms>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2015 at 11:12:25AM +1000, Michael Ellerman wrote:
> On Mon, 2015-04-27 at 06:59 -0400, Julian Margetson wrote:
> > Kernel 4.1-rc1 build fails  on Sam460ex amcc 460ex powerpc Canyonlands with 
> > CONFIG_SATA_DWC=y
> > 
> > sata_dwc_460ex.c:(.text+0xa165c): undefined reference to `dw_dma_remove'
> > drivers/built-in.o: In function `sata_dwc_probe':
> > sata_dwc_460ex.c:(.text+0xa1900): undefined reference to `dw_dma_probe'
> > sata_dwc_460ex.c:(.text+0xa1954): undefined reference to `dw_dma_remove'
> > make: *** [vmlinux] Error 1
> 
> Looks like it was caused by:
> 
> commit 8b3444852a2b58129ee68a8dd69fef81ceb902a1
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Tue Mar 3 22:41:21 2015 +0200
> 
>     sata_dwc_460ex: move to generic DMA driver

Oops, Andy?

-- 
tejun
