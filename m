Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x22f.google.com (mail-lb0-x22f.google.com
 [IPv6:2a00:1450:4010:c04::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C85261A0029
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Aug 2014 18:53:33 +1000 (EST)
Received: by mail-lb0-f175.google.com with SMTP id u10so4454005lbd.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Aug 2014 01:53:28 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1409369788-22563-1-git-send-email-bobby.prani@gmail.com>
References: <1409369788-22563-1-git-send-email-bobby.prani@gmail.com>
Date: Sun, 31 Aug 2014 10:53:28 +0200
Message-ID: <CAMuHMdV_naTfQOLwOshWq1Q15kSE39a8GWChsjt3RrWRcd6peg@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc: Wire up three syscalls
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pranith Kumar <bobby.prani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: open list <linux-kernel@vger.kernel.org>, Fabian Frederick <fabf@skynet.be>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pranith,

On Sat, Aug 30, 2014 at 5:36 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> I see that the three syscalls seccomp, getrandom and memfd_create are not wired
> because of which we get a warning while compilation.
>
> So I wired them up in this patch. What else needs to be done? I tried the
> memfd_test after compiling this kernel, but it is failing. What am I missing for
> this to work? Any advice is really appreciated! :)

Did it fail due to the (silly) "ifeq ($(ARCH),X86)" checks in
tools/testing/selftests/memfd/Makefile?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
