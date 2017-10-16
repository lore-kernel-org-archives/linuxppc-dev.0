Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFyhG4v4JzDrGr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 23:44:45 +1100 (AEDT)
Date: Mon, 16 Oct 2017 14:44:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
 linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: refactor dma_cache_sync V2
Message-ID: <20171016124442.GB2177@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
 <87817c6a-b03f-6da0-4e69-22ea68d44bd5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87817c6a-b03f-6da0-4e69-22ea68d44bd5@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 03, 2017 at 12:49:51PM +0100, Robin Murphy wrote:
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks Robin.  I've heard very little from the arch maintainers,
but if people remain silent I will apply the whole series to the
dma-mapping tree in the next days.
