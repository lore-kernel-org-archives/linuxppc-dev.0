Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by ozlabs.org (Postfix) with ESMTP id 1FB1B2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 04:29:23 +1000 (EST)
Date: Thu, 30 May 2013 23:17:27 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>
Subject: Re: [PATCH 00/12] dma: various minor clean ups for slave drivers
Message-ID: <20130530174727.GE3767@intel.com>
References: <1369656882-25241-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369656882-25241-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>,
 linux-kernel@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>,
 Dan Williams <djbw@fb.com>, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 27, 2013 at 03:14:30PM +0300, Andy Shevchenko wrote:
> Here is a set of small independent patches that clean up or fix minor things
> across DMA slave drivers.
The series looks fine. I am going to wait a day more and apply, pls speak up if
you disagree and ack if you agree

--
~Vinod
> 
> Andy Shevchenko (12):
>   imx-sdma: remove useless variable
>   mxs-dma: remove useless variable
>   edma: no need to assign residue to 0 explicitly
>   ep93xx_dma: remove useless use of lock
>   fsldma: remove useless use of lock
>   mmp_pdma: remove useless use of lock
>   mpc512x_dma: remove useless use of lock
>   pch_dma: remove useless use of lock
>   tegra20-apb-dma: remove useless use of lock
>   ipu_idmac: re-use dma_cookie_status()
>   mmp_tdma: set cookies as well when asked for tx status
>   txx9dmac: return DMA_SUCCESS immediately from device_tx_status()
> 
>  drivers/dma/edma.c            |  2 --
>  drivers/dma/ep93xx_dma.c      | 10 +---------
>  drivers/dma/fsldma.c          | 10 +---------
>  drivers/dma/imx-sdma.c        |  9 +++------
>  drivers/dma/ipu/ipu_idmac.c   |  5 +----
>  drivers/dma/mmp_pdma.c        | 10 +---------
>  drivers/dma/mmp_tdma.c        |  3 ++-
>  drivers/dma/mpc512x_dma.c     | 10 +---------
>  drivers/dma/mxs-dma.c         |  4 +---
>  drivers/dma/pch_dma.c         |  9 +--------
>  drivers/dma/tegra20-apb-dma.c |  8 +++-----
>  drivers/dma/txx9dmac.c        | 13 ++++++-------
>  12 files changed, 21 insertions(+), 72 deletions(-)
> 
> -- 
> 1.8.2.rc0.22.gb3600c3
> 

-- 
