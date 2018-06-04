Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com
 [IPv6:2607:f8b0:400c:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ztWH5cDPzF14Y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 21:48:59 +1000 (AEST)
Received: by mail-vk0-x241.google.com with SMTP id e67-v6so19735089vke.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 04:48:59 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 13:48:55 +0200
Message-ID: <CAMuHMdV6sKMLGhWLELqJWXS8Vj5Cnh82NE8MYOwU6EDWvoSTrg@mail.gmail.com>
Subject: Re: [PATCH 03/11] macintosh/via-pmu: Don't clear shift register
 interrupt flag twice
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

On Sat, Jun 2, 2018 at 5:27 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Clearing the interrupt flag twice in succession creates a theoretical
> race condition. Fix this.

I would add that the caller of pmu_sr_intr() has already cleared the flag,
so the casual reviewer doesn't have to hunt for it.

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
