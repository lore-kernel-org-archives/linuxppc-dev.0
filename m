Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f196.google.com (mail-ua0-f196.google.com
 [209.85.217.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41f9zN3QX4zF0jn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 17:23:43 +1000 (AEST)
Received: by mail-ua0-f196.google.com with SMTP id o11-v6so7175747uak.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 00:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <3923d42d8e3a5e3ae3382d3354744fb6648d03a8.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <3923d42d8e3a5e3ae3382d3354744fb6648d03a8.1530519301.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Jul 2018 09:23:29 +0200
Message-ID: <CAMuHMdVLLyF=F7ArbXxmPioQF4F2qDq8Sis629BL_B0HrN4=Xg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
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
> Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
> device found in those models was never supported by this driver.
> Attempting to load the driver usually causes a boot hang.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
