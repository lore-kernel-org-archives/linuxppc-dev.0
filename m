Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 16C57B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 02:49:27 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 00/14] DMA-mapping framework redesign preparation
Date: Fri, 24 Feb 2012 15:48:59 +0000
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201202241548.59791.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, x86@kernel.org,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>, linux-kernel@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-mips@linux-mips.org,
 microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, discuss@x86-64.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 23 December 2011, Marek Szyprowski wrote:
> The solution we found is to introduce a new public dma mapping functions
> with additional attributes argument: dma_alloc_attrs and
> dma_free_attrs(). This way all different kinds of architecture specific
> buffer mappings can be hidden behind the attributes without the need of
> creating several versions of dma_alloc_ function.

Since the patches are now in linux-next, we should make sure that they
can actually get merged into 3.4.

I've looked at all the patches again and found them to be straightforward
and helpful, I hope we can get them merged next time. Please add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
