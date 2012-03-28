Return-Path: <m.szyprowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14]) by ozlabs.org (Postfix) with ESMTP id CC84EB6FF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2012 01:38:49 +1100 (EST)
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Received: from euspt2 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1L00IEMNCPQ270@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 28 Mar 2012 15:38:49 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1L00KDSNCIKQ@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 28 Mar 2012 15:38:43 +0100 (BST)
Date: Wed, 28 Mar 2012 16:38:40 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv2 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
In-reply-to: <4F72F603.2000803@mvista.com>
To: 'Sergei Shtylyov' <sshtylyov@mvista.com>
Message-id: <016001cd0cf0$7807bdb0$68173910$%szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
 <4F72F603.2000803@mvista.com>
Cc: linux-mips@linux-mips.org, 'Kevin Cernekee' <cernekee@gmail.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, 'Guan Xuetao' <gxt@mprc.pku.edu.cn>,
 linux-arch@vger.kernel.org, 'Stephen Rothwell' <sfr@canb.auug.org.au>,
 'Jonathan Corbet' <corbet@lwn.net>, x86@kernel.org,
 'Matt Turner' <mattst88@gmail.com>, 'Dezhong Diao' <dediao@cisco.com>,
 'Fenghua Yu' <fenghua.yu@intel.com>, 'Arnd Bergmann' <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, linaro-mm-sig@lists.linaro.org,
 'Ivan Kokshaysky' <ink@jurassic.park.msu.ru>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 'Thomas Gleixner' <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 'Richard Henderson' <rth@twiddle.net>, discuss@x86-64.org,
 'Michal Simek' <monstr@monstr.eu>, 'Tony Luck' <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, 'Richard Kuo' <rkuo@codeaurora.org>,
 'FUJITA Tomonori' <fujita.tomonori@lab.ntt.co.jp>,
 'Kyungmin Park' <kyungmin.park@samsung.com>,
 'Paul Mundt' <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
 'Andrew Morton' <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "'David S. Miller'" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sergei,

On Wednesday, March 28, 2012 1:29 PM Sergei Shtylyov wrote:

> On 27-03-2012 17:42, Marek Szyprowski wrote:
> 
> > Introduce new generic alloc and free methods with attributes argument.
> 
>     The method names don't match the ones in the subject.

Right, I will reword the subject to "common: dma-mapping: introduce generic alloc()
and free() methods".

> > Existing alloc_coherent and free_coherent can be implemented on top of the
> > new calls with NULL attributes argument. Later also dma_alloc_non_coherent
> > can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
> > dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.
> 
> > This way the drivers will get more generic, platform independent way of
> > allocating dma buffers with specific parameters.
> 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.ud.au>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
