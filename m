Return-Path: <vinod.koul@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 2C5E91A004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 02:33:11 +1100 (AEDT)
Date: Wed, 9 Mar 2016 21:06:46 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: xuelin.shi@nxp.com
Cc: pku.leo@gmail.com, linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine:fsldma: fix memory leak
Message-ID: <20160309153645.GC11154@localhost>
References: <1457416921-29147-1-git-send-email-xuelin.shi@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457416921-29147-1-git-send-email-xuelin.shi@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2016 at 02:02:01PM +0800, xuelin.shi@nxp.com wrote:
> From: Xuelin Shi <xuelin.shi@nxp.com>
> 
> adding unmap of sources and destinations while doing dequeue.

Applied, thanks

-- 
~Vinod
