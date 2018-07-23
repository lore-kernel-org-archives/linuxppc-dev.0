Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f196.google.com (mail-ua0-f196.google.com
 [209.85.217.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41YvJF6lG0zDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 18:08:29 +1000 (AEST)
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so11177812uao.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 01:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
 <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
 <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
 <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
 <alpine.LNX.2.21.1807222145330.56@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1807222145330.56@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Jul 2018 10:08:15 +0200
Message-ID: <CAMuHMdX-q1jGqpi84=AVuP=14t5S8qs-+NxJmLZ814nZL12M+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Joshua Thompson <funaho@jurai.org>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Meelis Roos <mroos@linux.ee>, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

On Sun, Jul 22, 2018 at 1:56 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 18 Jul 2018, I wrote:
> > On Wed, 18 Jul 2018, Arnd Bergmann wrote:
> > > I'd suggest we do it like below to make it consistent with the rest
> > > again, using the 1904..2040 range of dates and no warning for invalid
> > > dates.
> > >
> > > If you agree, I'll send that as a proper patch.
> >
> > Geert may instead wish to fixup or revert the patch he has committed
> > already...
>
> Geert, how do you want to handle this?
>
> Do you want a fixup patch or a v3 patch with the WARN_ON and the other two
> issues addressed?

Please send a fixup patch, for the m68k/master branch, which is non-rebasing.
I'll fold it into the original commit on the m68k/for-next branch.

> I'm willing to send either one if Arnd is okay with that. I'd really like
> to resolve this before the merge window opens, since my PMU patch series
> is affected.

+1. If it's not resolved (a few days) before the merge window opens, I may have
to revert the patch instead.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
