Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 422D02C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2012 06:27:38 +1100 (EST)
Received: by mail-la0-f51.google.com with SMTP id e4so2114260lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 11:27:35 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1355426667-3060-1-git-send-email-geert@linux-m68k.org>
References: <1355426667-3060-1-git-send-email-geert@linux-m68k.org>
Date: Thu, 13 Dec 2012 20:27:34 +0100
Message-ID: <CAMuHMdVaTp2MRYBcuMO1fEx_9GKVFHQbT4kmQqzWKe=WVzbi_A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.7
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2012 at 8:24 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.7 to v3.7-rc8[3], the summaries are:
>   - build errors: +2/-0

  + error: No rule to make target include/config/auto.conf:  => N/A

x86_64-randconfig

  + error: vga16fb.c: undefined reference to `vgacon_remap_base':  =>
.devinit.text+0x16b52), .devinit.text+0x16b5a)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5700/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5670/ (all 117 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
