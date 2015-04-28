Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 877F11A017C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:29:30 +1000 (AEST)
Received: by oblw8 with SMTP id w8so106801385obl.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 05:29:27 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <87pp6osaog.fsf@rustcorp.com.au>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
 <871tj4uara.fsf@rustcorp.com.au>
 <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
 <87pp6osaog.fsf@rustcorp.com.au>
Date: Tue, 28 Apr 2015 14:29:27 +0200
Message-ID: <CAMuHMdXEH6ZnTSdBi2uJzPriqTLvJvd0bPYH3NPWV5LjZB5S=A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.1-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Chris Metcalf <cmetcalf@ezchip.com>, Mark Brown <broonie@kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 Matthew Wilcox <willy@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cc Chris

On Tue, Apr 28, 2015 at 2:24 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>> Can't see that one with a simple grep: can you post warning?
>>
>> /home/kisskb/slave/src/arch/tile/kernel/setup.c: In function 'zone_sizes_init':
>> /home/kisskb/slave/src/arch/tile/kernel/setup.c:777:3: warning:
>> passing argument 2 of 'cpumask_test_cpu' from incompatible pointer
>> type [enabled by default]
>> /home/kisskb/slave/src/include/linux/cpumask.h:294:19: note: expected
>> 'const struct cpumask *' but argument is of type 'struct nodemask_t *'
>
> Um, I turned the cpu_isset() into cpumask_test_cpu(), but that just
> showed this bug up.  The tile maintainers need to fix this one.
>
> Thanks,
> Rusty.
