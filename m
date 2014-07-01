Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com
 [IPv6:2a00:1450:4010:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4EAF1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 18:01:44 +1000 (EST)
Received: by mail-la0-f41.google.com with SMTP id hz20so5698479lab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Jul 2014 01:01:38 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1404201524-7568-1-git-send-email-geert@linux-m68k.org>
References: <1404201524-7568-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 1 Jul 2014 10:01:38 +0200
Message-ID: <CAMuHMdXrvFRRESU7T-nk8WkNgrTSvOvyywMjcRC=OQH7CbbQjw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.16-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 1, 2014 at 9:58 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.16-rc3[1]  to v3.16-rc2[3], the summaries are:
>   - build errors: +5/-63

  + /scratch/kisskb/src/kernel/bounds.c: error: -mcall-aixdesc must be
big endian:  => 1:0
  + /scratch/kisskb/src/scripts/mod/devicetable-offsets.c: error:
-mcall-aixdesc must be big endianmake[3]: :  => 1:0
  + /scratch/kisskb/src/scripts/mod/empty.c: error: -mcall-aixdesc
must be big endian:  => 1:0
  + <stdin>: error: -mcall-aixdesc must be big endian:  => 1:0

powerpc-randconfig

  + error: misc.c: undefined reference to `ftrace_likely_update':  =>
.text+0x22c), .text+0x898)

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7619/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7595/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
