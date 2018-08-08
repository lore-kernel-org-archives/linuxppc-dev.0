Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lrH75ZxnzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 22:26:59 +1000 (AEST)
Received: by mail-lj1-f175.google.com with SMTP id s12-v6so1585291ljj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 05:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
 <20180806155440.9dcb271a3b075bd964aec60f@linux-foundation.org>
 <87lg9hb12y.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lg9hb12y.fsf@concordia.ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Aug 2018 14:26:43 +0200
Message-ID: <CAMuHMdW-aaiPVp4wLJDBzE84C1PdS20y688ePWqafnSU=UOSYQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 8, 2018 at 12:32 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Also I haven't been seeing this in my local builds because I have:
>
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
>
> So I guess we need to work out why that's interfering with section
> mismatch analysis.

One other common case of missing section mismatch warnings is when some
versions of the compiler inline the called function, while other versions don't.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
