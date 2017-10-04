Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6VQ31b3FzDqmb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 20:06:34 +1100 (AEDT)
Date: Wed, 4 Oct 2017 11:06:31 +0200
From: 'Christoph Hellwig' <hch@lst.de>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Christoph Hellwig' <hch@lst.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 04/11] ia64: make dma_cache_sync a no-op
Message-ID: <20171004090631.GA23669@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-5-hch@lst.de>
 <063D6719AE5E284EB5DD2968C1650D6DD0089626@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0089626@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 04, 2017 at 08:59:24AM +0000, David Laight wrote:
> Are you sure about this one?

Yes.  And if you are not you haven't read either of the cover letter,
the DMA-API documentation, or the reply from Thomas to your mail
yesterday.
