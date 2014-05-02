Return-Path: <vinod.koul@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 6C5ED140328
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 03:03:53 +1000 (EST)
Date: Fri, 2 May 2014 22:18:47 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v4 2/8] DMA: Freescale: unify register access methods
Message-ID: <20140502164847.GD32284@intel.com>
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
 <1397809071-5353-3-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397809071-5353-3-git-send-email-hongbo.zhang@freescale.com>
Cc: leo.li@freescale.com, vkoul@infradead.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2014 at 04:17:45PM +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> Methods of accessing DMA controller registers are inconsistent, some registers
> are accessed by DMA_IN/OUT directly, while others are accessed by functions
> get/set_* which are wrappers of DMA_IN/OUT, and even for the BCR register, it
> is read by get_bcr but written by DMA_OUT.
> This patch unifies the inconsistent methods, all registers are accessed by
> get/set_* now.
> 
Applied, thanks

-- 
~Vinod
