Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vw9Y3Qv2zF3Hy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 21:37:19 +1000 (AEST)
Received: by mail-vk0-f67.google.com with SMTP id p12-v6so2305220vkf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-3-arnd@arndb.de>
In-Reply-To: <20180619140229.3615110-3-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Jul 2018 13:37:05 +0200
Message-ID: <CAMuHMdV2tSqXWgOiUtNjmCnQa2VSVddS9iHKb=5dvV9ChYNxsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v2] m68k: remove unused set_clock_mmss() helpers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Joshua Thompson <funaho@jurai.org>, Mathieu Malaterre <malat@debian.org>,
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

On Tue, Jun 19, 2018 at 4:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Commit 397ac99c6cef ("m68k: remove dead timer code") removed set_rtc_mmss()
> because it was unused in 2012. However, this was itself the only user of the
> mach_set_clock_mmss() callback and the many implementations of that callback,
> which are equally unused.
>
> This removes all of those as well.
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied and queued for v4.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
