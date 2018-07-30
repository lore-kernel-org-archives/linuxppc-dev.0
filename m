Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fB3z4N32zF18k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 17:27:43 +1000 (AEST)
Received: by mail-ua0-f194.google.com with SMTP id u11-v6so2467080uan.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 00:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
 <87tvohi5ji.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvohi5ji.fsf@concordia.ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Jul 2018 09:27:30 +0200
Message-ID: <CAMuHMdURrJ6d22QCBsX9NKvmtaVckWKGayohgidBPpZoxwTrWg@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] macintosh/via-pmu: Replace via-pmu68k driver
 with via-pmu driver
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Mon, Jul 30, 2018 at 8:47 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Finn Thain <fthain@telegraphics.com.au> writes:
> > Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> > switch over to that driver and remove the via-pmu68k driver.
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> >  arch/m68k/configs/mac_defconfig   |   2 +-
> >  arch/m68k/configs/multi_defconfig |   2 +-
> >  arch/m68k/mac/config.c            |   2 +-
> >  arch/m68k/mac/misc.c              |  48 +--
> >  drivers/macintosh/Kconfig         |  13 +-
> >  drivers/macintosh/Makefile        |   1 -
> >  drivers/macintosh/adb.c           |   2 +-
> >  drivers/macintosh/via-pmu68k.c    | 846 --------------------------------------
> >  include/uapi/linux/pmu.h          |   2 +-
> >  9 files changed, 14 insertions(+), 904 deletions(-)
> >  delete mode 100644 drivers/macintosh/via-pmu68k.c
>
> Geert are you OK with this and the other one that touches arch/m68k ?

Sure, feel free to take them through the PPC tree.
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
