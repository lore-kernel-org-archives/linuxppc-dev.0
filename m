Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 529EE1A1811
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 17:26:58 +1000 (AEST)
Received: by oiyy130 with SMTP id y130so112038476oiy.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 00:26:56 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150628014200.233057221@telegraphics.com.au>
References: <20150628014159.732792697@telegraphics.com.au>
 <20150628014200.233057221@telegraphics.com.au>
Date: Mon, 29 Jun 2015 09:26:56 +0200
Message-ID: <CAMuHMdUY2pM4N3Uddo2TecNo2BL4t-7VVDY=2wrgsqomVnCXFg@mail.gmail.com>
Subject: Re: [RFC v3 02/24] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

On Sun, Jun 28, 2015 at 3:42 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Change the vmode calculation from logical OR to bitwise OR, since it is
> obviously wrong.

Ideally, that should be a separate patch we can put on the fast track.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
