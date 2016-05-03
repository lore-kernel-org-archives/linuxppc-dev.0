Return-Path: <vinod.koul@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qzWxV46R8zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:49:34 +1000 (AEST)
Date: Tue, 3 May 2016 12:25:34 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-kernel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5] Use dma_pool_zalloc
Message-ID: <20160503065533.GO2274@localhost>
References: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 29, 2016 at 10:09:07PM +0200, Julia Lawall wrote:
> Dma_pool_zalloc combines dma_pool_alloc and memset 0.  The semantic patch
> that makes this transformation is as follows: (http://coccinelle.lip6.fr/)

Applied all dmaengine patches

-- 
~Vinod
