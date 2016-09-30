Return-Path: <vinod.koul@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slzSC0kV3zDvKQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Oct 2016 03:48:09 +1000 (AEST)
Date: Fri, 30 Sep 2016 23:26:39 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: leoli@freescale.com, zw@zh-kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/fsldma : Unmap region obtained by of_iomap
Message-ID: <20160930175638.GZ2467@localhost>
References: <1475059511-10114-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475059511-10114-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 04:15:11PM +0530, Arvind Yadav wrote:
> Free memory mapping, if probe is not successful.

Please use proper subsystem tags for patches. Hint: use git log to find that
out

Applied after fixing the tag

-- 
~Vinod
