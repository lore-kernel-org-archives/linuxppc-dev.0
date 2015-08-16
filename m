Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x22f.google.com (mail-oi0-x22f.google.com
 [IPv6:2607:f8b0:4003:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D8701A0392
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2015 19:15:28 +1000 (AEST)
Received: by oio137 with SMTP id 137so65637996oio.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2015 02:15:25 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150725074559.543547894@telegraphics.com.au>
References: <20150725074559.543547894@telegraphics.com.au>
Date: Sun, 16 Aug 2015 11:15:25 +0200
Message-ID: <CAMuHMdWUQsSG8cZmKX8tHMN1=87Og-xboAFzhP1vWyQF+A3_eg@mail.gmail.com>
Subject: Re: [RFC v5 00/26] Re-use nvram module
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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

On Sat, Jul 25, 2015 at 9:45 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The generic NVRAM module, drivers/char/generic_nvram, implements a
> /dev/nvram misc device. It is used only by 32-bit PowerPC platforms and
> isn't generic enough to be more widely used.

[...]

Thanks!

You can add my
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
to patches 03, 04, 11, 19, 23, 24, 25, 26.

BTW, checkpatch reported a few newly-introduced whitespace errors in patches
03, 05, 16, 24, and 25.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
