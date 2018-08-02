Return-Path: <alex.bou9@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hC0j3GBbzF21L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 00:16:52 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id v26-v6so1974596iog.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 07:16:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
From: Alex Bounine <alex.bou9@gmail.com>
In-Reply-To: <20180802140033.GH38497@guest228.east.isi.edu>
Date: Thu, 2 Aug 2018 10:16:48 -0400
Cc: Christoph Hellwig <hch@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jwalters@isi.edu,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Message-Id: <D6EE6CE1-FB11-41EB-B787-A093D26CE3E3@gmail.com>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
 <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
 <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
 <20180802134544.GG38497@guest228.east.isi.edu>
 <20180802135421.GA13512@infradead.org>
 <20180802140033.GH38497@guest228.east.isi.edu>
To: Alexei Colin <acolin@isi.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I will experiment with this idea.
Please keep me in CC as well.

Sent from my iPad

> On Aug 2, 2018, at 10:00 AM, Alexei Colin <acolin@isi.edu> wrote:
> 
>> On Thu, Aug 02, 2018 at 06:54:21AM -0700, Christoph Hellwig wrote:
>>> On Thu, Aug 02, 2018 at 09:45:44AM -0400, Alexei Colin wrote:
>>> If I move RapidIO option to drivers/Kconfig, then it won't appear under
>>> the Bus Options/System Support menu, along with other choices for the
>>> system bus (PCI, PCMCIA, ISA, TC, ...).
>> 
>> It's not like anyone cares.  And FYI, moving all those to
>> drivers/Kconfig is osmething I will submit for the next merge window.
> 
> Ok, I would appreciate a CC on that patch. After it lands, if
> there is time, I'll resubmit a rebased version of this patch.
