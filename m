Return-Path: <acolin@isi.edu>
Received: from mail-d.ads.isi.edu (mail-d.ads.isi.edu [128.9.180.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hBdx6zf4zF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 00:00:36 +1000 (AEST)
Date: Thu, 2 Aug 2018 10:00:33 -0400
From: Alexei Colin <acolin@isi.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, alex.bou9@gmail.com,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jwalters@isi.edu, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180802140033.GH38497@guest228.east.isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
 <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
 <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
 <20180802134544.GG38497@guest228.east.isi.edu>
 <20180802135421.GA13512@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180802135421.GA13512@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2018 at 06:54:21AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 02, 2018 at 09:45:44AM -0400, Alexei Colin wrote:
> > If I move RapidIO option to drivers/Kconfig, then it won't appear under
> > the Bus Options/System Support menu, along with other choices for the
> > system bus (PCI, PCMCIA, ISA, TC, ...).
> 
> It's not like anyone cares.  And FYI, moving all those to
> drivers/Kconfig is osmething I will submit for the next merge window.

Ok, I would appreciate a CC on that patch. After it lands, if
there is time, I'll resubmit a rebased version of this patch.
