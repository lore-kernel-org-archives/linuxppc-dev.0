Return-Path: <sshtylyov@mvista.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DECF7B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 22:30:44 +1100 (EST)
Received: by bkwj10 with SMTP id j10so810657bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 04:30:39 -0700 (PDT)
Message-ID: <4F72F603.2000803@mvista.com>
Date: Wed, 28 Mar 2012 15:29:07 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCHv2 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
 Matt Turner <mattst88@gmail.com>, Dezhong Diao <dediao@cisco.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, linaro-mm-sig@lists.linaro.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, discuss@x86-64.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
 Kyungmin Park <kyungmin.park@samsung.com>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 27-03-2012 17:42, Marek Szyprowski wrote:

> Introduce new generic alloc and free methods with attributes argument.

    The method names don't match the ones in the subject.

> Existing alloc_coherent and free_coherent can be implemented on top of the
> new calls with NULL attributes argument. Later also dma_alloc_non_coherent
> can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
> dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.

> This way the drivers will get more generic, platform independent way of
> allocating dma buffers with specific parameters.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.ud.au>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

WBR, Sergei
