Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com
 [IPv6:2607:f8b0:4003:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C24C1A0C33
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 17:40:55 +1000 (AEST)
Received: by oiww2 with SMTP id w2so95250727oiw.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2015 00:40:52 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150531010132.549451549@telegraphics.com.au>
References: <20150531010132.289674310@telegraphics.com.au>
 <20150531010132.549451549@telegraphics.com.au>
Date: Mon, 1 Jun 2015 09:40:52 +0200
Message-ID: <CAMuHMdVmoggmChSaDefu4SohCfTYiJeArdT3=i5jqfQwqByV-A@mail.gmail.com>
Subject: Re: [RFC 01/24] macintosh/nvram: Remove as unused
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 31, 2015 at 3:01 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Removal seems to be forgotten by full-history-linux
commit 17c6f4635bea74e110ab3558d408c9cd218c568a
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Fri Feb 6 14:20:56 2004 +1100

    ppc32: Rework nvram management

    move drivers/macintosh/nvram.c to drivers/char/generic_nvram.c,
    update platform hooks,
    fix powermac nvram driver for newer machines

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
