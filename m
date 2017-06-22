Return-Path: <vinod.koul@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wthVY4PTnzDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 22:59:15 +1000 (AEST)
Date: Thu, 22 Jun 2017 18:31:57 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Thomas Breitung <thomas.breitung@izt-labs.de>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Li Yang <leoli@freescale.com>,
 Zhang Wei <zw@zh-kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Wolfgang Ocker <weo@reccoware.de>
Subject: Re: [PATCH] dmaengine: fsldma: set BWC, DAHTS and SAHTS values
 correctly
Message-ID: <20170622130157.GU19154@localhost>
References: <20170619144004.18224-1-thomas.breitung@izt-labs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619144004.18224-1-thomas.breitung@izt-labs.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 19, 2017 at 04:40:04PM +0200, Thomas Breitung wrote:
> The bits of BWC, DAHTS and SAHTS in the DMA mode register must be cleared
> before a new value can be or-ed in.

Applied, thanks

-- 
~Vinod
