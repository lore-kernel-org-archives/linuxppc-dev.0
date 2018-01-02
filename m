Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z9rBB1xgRzDqy3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jan 2018 21:38:10 +1100 (AEDT)
Received: by mail-qk0-x241.google.com with SMTP id j137so43070539qke.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jan 2018 02:38:10 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20171229081911.2802-23-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-23-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2018 11:38:07 +0100
Message-ID: <CAMuHMdX6+E0tN-qxybQ27DoygpUsWngi8J+Fz6K2WZ=FCCuO_A@mail.gmail.com>
Subject: Re: [PATCH 22/67] dma-mapping: clear harmful GFP_* flags in common
 code
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, alpha <linux-alpha@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 Cris <linux-cris-kernel@axis.com>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> Life the code from x86 so that we behave consistently.  In the future we
> should probably warn if any of these is set.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
