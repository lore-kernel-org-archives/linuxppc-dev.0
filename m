Return-Path: <bsingharora@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGhWm4xsxzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 21:09:24 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id 75so12858759lfs.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 May 2017 04:09:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201705011829.pgKWNzqt%fengguang.wu@intel.com>
References: <20170501063438.25237-3-bsingharora@gmail.com>
 <201705011829.pgKWNzqt%fengguang.wu@intel.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 1 May 2017 21:09:20 +1000
Message-ID: <CAKTCnznHZBL-rHEPiL45BRu0ydXpDPmkmENPCiXqq1Dx2+SiCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc/mm/book(e)(3s)/32: Add page table
 accounting
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Vladimir Davydov <vdavydov@virtuozzo.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 1, 2017 at 8:31 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Balbir,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.11 next-20170428]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Balbir-Singh/powerpc-mm-book-e-3s-64-Add-page-table-accounting/20170501-143900
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-virtex5_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from arch/powerpc/mm/mem.c:25:0:
>    arch/powerpc/include/asm/nohash/32/pgalloc.h: In function 'pgd_alloc':
>>> include/linux/gfp.h:240:20: error: passing argument 1 of 'pgtable_gfp_flags' makes pointer from integer without a cast [-Werror=int-conversion]
>     #define GFP_KERNEL (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
>                        ^
>    arch/powerpc/include/asm/nohash/32/pgalloc.h:35:22: note: in expansion of macro 'GFP_KERNEL'
>        pgtable_gfp_flags(GFP_KERNEL));

That's a silly build error that escaped my build scripts, I'll send
out a better v3 with 32 bits fixed.

Balbir
