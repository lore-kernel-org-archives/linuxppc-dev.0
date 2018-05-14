Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kh0L4TCDzF2S5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 10:09:53 +1000 (AEST)
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com
 [209.85.217.173]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w4E09XkD010754
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 09:09:33 +0900
Received: by mail-ua0-f173.google.com with SMTP id g9-v6so7173687uak.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2018 17:09:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509130001.24276-1-npiggin@gmail.com>
References: <20180509130001.24276-1-npiggin@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 14 May 2018 09:08:52 +0900
Message-ID: <CAK7LNARVkvM1deFGbdnaTt41hDqV9pCZ1+OCB0dCqPgspLMVPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling
 for powerpc
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2018-05-09 21:59 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> v2 changes only patch 4, updates the changelog with ppc32 numbers and
> Tested-by tags, and also use TEXT_MAIN in the linker script as
> Christophe suggested.


Replaced with v2.
Thanks!


> Thanks,
> Nick
>
> Nicholas Piggin (4):
>   kbuild: Fix asm-generic/vmlinux.lds.h for
>     LD_DEAD_CODE_DATA_ELIMINATION
>   kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
>     -ffunction-sections/-fdata-sections for module build
>   kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if
>     enabled
>   powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected
>
>  Makefile                          |  4 +--
>  arch/Kconfig                      | 15 ----------
>  arch/powerpc/Kconfig              |  1 +
>  arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++-------
>  include/asm-generic/vmlinux.lds.h | 49 ++++++++++++++++++-------------
>  init/Kconfig                      | 27 +++++++++++++++++
>  6 files changed, 70 insertions(+), 48 deletions(-)
>
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
