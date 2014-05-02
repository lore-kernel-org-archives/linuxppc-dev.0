Return-Path: <vinod.koul@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 9D0691412DE
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 03:02:48 +1000 (EST)
Date: Fri, 2 May 2014 22:19:32 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v4 4/8] DMA: Freescale: add fsl_dma_free_descriptor()
 to reduce code duplication
Message-ID: <20140502164932.GF32284@intel.com>
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
 <1397809071-5353-5-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397809071-5353-5-git-send-email-hongbo.zhang@freescale.com>
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

On Fri, Apr 18, 2014 at 04:17:47PM +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> There are several places where descriptors are freed using identical code.
> This patch puts this code into a function to reduce code duplication.
> 
Applied, thanks

-- 
~Vinod
