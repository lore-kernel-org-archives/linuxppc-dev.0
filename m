Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x22b.google.com (mail-la0-x22b.google.com
 [IPv6:2a00:1450:4010:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3375E1A000F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 18:53:59 +1000 (EST)
Received: by mail-la0-f43.google.com with SMTP id gi9so8291158lab.16
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 01:53:54 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1411461080-4061-1-git-send-email-geert@linux-m68k.org>
References: <1411461080-4061-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 23 Sep 2014 10:53:54 +0200
Message-ID: <CAMuHMdUcuKUpwB9K4BJY1U_rwLiG_Q4DgHZ5eqWBsiWjDpykXw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.17-rc6 (take two)
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

On Tue, Sep 23, 2014 at 10:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.17-rc6[1]  to v3.17-rc5[3], the summaries are:
>   - build errors: +9/-10

  + /scratch/kisskb/src/drivers/net/ethernet/amd/lance.c: error:
implicit declaration of function 'isa_bus_to_virt'
[-Werror=implicit-function-declaration]:  => 1204:6
  + /scratch/kisskb/src/drivers/net/ethernet/amd/lance.c: error:
implicit declaration of function 'isa_virt_to_bus'
[-Werror=implicit-function-declaration]:  => 575:2
  + /scratch/kisskb/src/drivers/net/ethernet/cirrus/cs89x0.c: error:
implicit declaration of function 'isa_virt_to_bus'
[-Werror=implicit-function-declaration]:  => 892:3
  + /scratch/kisskb/src/drivers/scsi/aha1542.c: error: implicit
declaration of function 'isa_page_to_bus'
[-Werror=implicit-function-declaration]:  => 674:4
  + /scratch/kisskb/src/drivers/scsi/aha1542.c: error: implicit
declaration of function 'isa_virt_to_bus'
[-Werror=implicit-function-declaration]:  => 477:3
  + /scratch/kisskb/src/drivers/scsi/wd7000.c: error: implicit
declaration of function 'isa_bus_to_virt'
[-Werror=implicit-function-declaration]:  => 1055:2
  + /scratch/kisskb/src/drivers/scsi/wd7000.c: error: implicit
declaration of function 'isa_page_to_bus'
[-Werror=implicit-function-declaration]:  => 1121:4
  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7891/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7872/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
