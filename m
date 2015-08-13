Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BAEB1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 03:55:45 +1000 (AEST)
Date: Thu, 13 Aug 2015 19:55:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
 arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com,
 ysato@users.sourceforge.jp, monstr@monstr.eu, jonas@southpole.se,
 cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: consolidate dma_{alloc,free}_noncoherent
Message-ID: <20150813175541.GA21103@lst.de>
References: <1439478248-15183-1-git-send-email-hch@lst.de>
 <1439478248-15183-3-git-send-email-hch@lst.de>
 <20150813152040.GQ7557@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150813152040.GQ7557@n2100.arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 13, 2015 at 04:20:40PM +0100, Russell King - ARM Linux wrote:
> > -/*
> > - * Dummy noncoherent implementation.  We don't provide a dma_cache_sync
> > - * function so drivers using this API are highlighted with build warnings.
> > - */
> 
> I'd like a similar comment to remain after this patch explaining that we
> don't support non-coherent allocations and that it'll be highlighted by
> the lack of dma_cache_sync, otherwise I'm sure we'll start to get patches
> to add the thing.

I'll keep a modified version of this comment in the ARM dma-mapping.h
in addition to an explanation near the new common dma_alloc_noncoherent
definition, thanks!
