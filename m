Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x22e.google.com (mail-la0-x22e.google.com
 [IPv6:2a00:1450:4010:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2CD01A064A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 07:50:08 +1100 (AEDT)
Received: by mail-la0-f46.google.com with SMTP id s18so9897837lam.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 12:50:04 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1422304140-24420-1-git-send-email-geert@linux-m68k.org>
References: <1422304140-24420-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 26 Jan 2015 21:50:03 +0100
Message-ID: <CAMuHMdX5YCPgpHjNDpkeQc=Kx-yY7LPBikRoNa+9zS1S-K1EUg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.19-rc6
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 26, 2015 at 9:29 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.19-rc6[1] to v3.19-rc5[3], the summaries are:
>   - build errors: +9/-9

  + /home/kisskb/slave/src/arch/powerpc/kvm/book3s_pr.c: error:
'last_sc' may be used uninitialized in this function
[-Werror=uninitialized]:  => 1094:31

powerpc-randconfig (demoted to a warning in powerpc-allyesconfig and
powerpc-allmodconfig)

  + /home/kisskb/slave/src/mm/memory_hotplug.c: error:
'PAGES_PER_SECTION' undeclared (first use in this function):  =>
1178:18, 1836:46
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error:
'PAGE_SECTION_MASK' undeclared (first use in this function):  =>
1177:20
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function '__nr_to_section'
[-Werror=implicit-function-declaration]:  => 1841:3
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function 'find_memory_block_hinted'
[-Werror=implicit-function-declaration]:  => 1848:3
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function 'pfn_to_section_nr'
[-Werror=implicit-function-declaration]:  => 1837:3
  + /home/kisskb/slave/src/mm/memory_hotplug.c: error: implicit
declaration of function 'present_section_nr'
[-Werror=implicit-function-declaration]:  => 1838:3

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8360/ (255 out of 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8329/ (255 out of 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
