Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fB3d5qGPzF1BL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 17:27:25 +1000 (AEST)
Received: by mail-ua0-f194.google.com with SMTP id k25-v6so7172635uao.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 00:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
 <CAMuHMdU_7V0n6HCNR87pmxYSMJxC=WpbtChpdzT2DQi3VWBZ7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdU_7V0n6HCNR87pmxYSMJxC=WpbtChpdzT2DQi3VWBZ7Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Jul 2018 09:27:11 +0200
Message-ID: <CAMuHMdXFo8RxfkHJ5z11kzj1Nn_1tZEgDjJb_kC4MSf5aE+27Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] macintosh/via-pmu: Replace via-pmu68k driver
 with via-pmu driver
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
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

On Mon, Jul 30, 2018 at 9:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Jul 2, 2018 at 10:21 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> > switch over to that driver and remove the via-pmu68k driver.
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
