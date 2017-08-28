Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xghcR4zmnzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 16:26:31 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id t193so2671538pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Aug 2017 23:26:31 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170827161032.22772-13-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
 <20170827161032.22772-13-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Aug 2017 08:26:29 +0200
Message-ID: <CAMuHMdVwHx2aATKqYS7xXTjnCigoZzVFFfcZOmvNj3KcFFJehg@mail.gmail.com>
Subject: Re: [PATCH 12/12] dma-mapping: turn dma_cache_sync into a dma_map_ops
 method
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On Sun, Aug 27, 2017 at 6:10 PM, Christoph Hellwig <hch@lst.de> wrote:
> After we removed all the dead wood it turns out only two architectures
> actually implement dma_cache_sync as a no-op: mips and parisc.  Add

s/no-op/real op/

> a cache_sync method to struct dma_map_ops and implement it for the
> mips defualt DMA ops, and the parisc pa11 ops.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
