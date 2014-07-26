Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x232.google.com (mail-la0-x232.google.com
 [IPv6:2a00:1450:4010:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE2A31A044B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jul 2014 01:46:35 +1000 (EST)
Received: by mail-la0-f50.google.com with SMTP id gf5so3987160lab.23
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jul 2014 08:46:29 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1406389175-9745-1-git-send-email-geert@linux-m68k.org>
References: <1406389175-9745-1-git-send-email-geert@linux-m68k.org>
Date: Sat, 26 Jul 2014 17:46:28 +0200
Message-ID: <CAMuHMdWM_Nbpj9nv6SctPcB0ygE0wzx=LpS4OFgq8ES9ZHcSBg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.16-rc5
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

On Sat, Jul 26, 2014 at 5:39 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.16-rc5[1]  to v3.16-rc4[3], the summaries are:
>   - build errors: +14/-11

  + /scratch/kisskb/src/mm/memory_hotplug.c: error:
'PAGES_PER_SECTION' undeclared (first use in this function):  =>
1779:46, 1887:46, 1149:18
  + /scratch/kisskb/src/mm/memory_hotplug.c: error:
'PAGE_SECTION_MASK' undeclared (first use in this function):  =>
1148:20
  + /scratch/kisskb/src/mm/memory_hotplug.c: error:
'PFN_SECTION_SHIFT' undeclared (first use in this function):  =>
1348:31
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function '__nr_to_section'
[-Werror=implicit-function-declaration]:  => 1784:3
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function 'find_memory_block_hinted'
[-Werror=implicit-function-declaration]:  => 1791:3
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function 'pfn_to_section_nr'
[-Werror=implicit-function-declaration]:  => 1780:3
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function 'present_section_nr'
[-Werror=implicit-function-declaration]:  => 1781:3
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function 'section_nr_to_pfn'
[-Werror=implicit-function-declaration]:  => 1816:3

powerpc-randconfig

(ignoring a few more R_PPC64_REL24 truncated relocations in
powerpc-allyesconfig)

> [1] http://kisskb.ellerman.id.au/kisskb/head/7665/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7639/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
