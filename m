Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vk0-f68.google.com (mail-vk0-f68.google.com
 [209.85.213.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fB2c2VmTzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 17:26:31 +1000 (AEST)
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so5239543vkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 00:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Jul 2018 09:26:17 +0200
Message-ID: <CAMuHMdU_7V0n6HCNR87pmxYSMJxC=WpbtChpdzT2DQi3VWBZ7Q@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 10:21 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> switch over to that driver and remove the via-pmu68k driver.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
