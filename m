Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x234.google.com (mail-la0-x234.google.com
 [IPv6:2a00:1450:4010:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6A9A1A0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 19:10:40 +1000 (EST)
Received: by mail-la0-f52.google.com with SMTP id gq15so6351231lab.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 02:10:35 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1411376728-15807-1-git-send-email-geert@linux-m68k.org>
References: <1411376728-15807-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 22 Sep 2014 11:10:35 +0200
Message-ID: <CAMuHMdVwOYB0HzYY_Uu+kKapC3eHSoV-=t1QHLFzgcGX2UOYoQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.17-rc5
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

On Mon, Sep 22, 2014 at 11:05 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.17-rc5[1]  to v3.17-rc4[3], the summaries are:
>   - build errors: +13/-3

  + /scratch/kisskb/src/arch/powerpc/kernel/iommu.c: error:
'fail_iommu_bus_notifier' defined but not used
[-Werror=unused-variable]:  => 149:30
  + /scratch/kisskb/src/mm/memory_hotplug.c: error:
'PAGES_PER_SECTION' undeclared (first use in this function):  =>
1918:46, 1810:46, 1152:18
  + /scratch/kisskb/src/mm/memory_hotplug.c: error:
'PAGE_SECTION_MASK' undeclared (first use in this function):  =>
1151:20
  + /scratch/kisskb/src/mm/memory_hotplug.c: error:
'PFN_SECTION_SHIFT' undeclared (first use in this function):  =>
1379:31
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function '__nr_to_section'
[-Werror=implicit-function-declaration]:  => 1815:3
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function 'find_memory_block_hinted'
[-Werror=implicit-function-declaration]:  => 1822:3
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function 'pfn_to_section_nr'
[-Werror=implicit-function-declaration]:  => 1811:3
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function 'present_section_nr'
[-Werror=implicit-function-declaration]:  => 1812:3
  + /scratch/kisskb/src/mm/memory_hotplug.c: error: implicit
declaration of function 'section_nr_to_pfn'
[-Werror=implicit-function-declaration]:  => 1847:3

powerpc-randconfig

+ a few new R_PPC64_REL24.

> [1] http://kisskb.ellerman.id.au/kisskb/head/7872/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7854/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
