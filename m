Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tsYC352b0zDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2017 21:26:23 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id j76so29461731ioe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2017 02:26:23 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <b44eec45f78cd84d9e3d6ff6c2d303ced19b0eca.1483055859.git.fthain@telegraphics.com.au>
References: <cover.1483055859.git.fthain@telegraphics.com.au>
 <b44eec45f78cd84d9e3d6ff6c2d303ced19b0eca.1483055859.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jan 2017 11:26:21 +0100
Message-ID: <CAMuHMdWFaaZdKa7+T6nruEv1sB8yYAm9yZLgy-UwefxM4b8MaA@mail.gmail.com>
Subject: Re: [PATCH RESEND 10/10] m68k/mac: Replace via-maciisi driver with
 via-cuda driver
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn, Ben,

On Sun, Jan 1, 2017 at 1:56 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Change the device probe test in the via-cuda.c driver so it will load on
> Egret-based machines too. Remove the now redundant via-maciisi.c driver.
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I guess this will go in with the rest of the series through Ben's
macintosh tree?

> ---
>  arch/m68k/include/asm/macintosh.h |   2 +-
>  arch/m68k/mac/config.c            |  18 +-
>  arch/m68k/mac/misc.c              |  72 +---
>  drivers/macintosh/Kconfig         |  24 +-
>  drivers/macintosh/Makefile        |   1 -
>  drivers/macintosh/adb.c           |   4 -
>  drivers/macintosh/via-cuda.c      |   8 +-
>  drivers/macintosh/via-maciisi.c   | 677 --------------------------------------
>  8 files changed, 30 insertions(+), 776 deletions(-)
>  delete mode 100644 drivers/macintosh/via-maciisi.c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
