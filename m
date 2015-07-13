Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com
 [IPv6:2607:f8b0:4003:c01::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A42F11A02BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 17:55:34 +1000 (AEST)
Received: by obbgp5 with SMTP id gp5so112114207obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 00:55:31 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150712102527.356151908@telegraphics.com.au>
References: <20150712102527.356151908@telegraphics.com.au>
Date: Mon, 13 Jul 2015 09:55:31 +0200
Message-ID: <CAMuHMdX+5XHWf3sVqAnF_mioS1zZmxQXurEeMGMM3OKa9acxhA@mail.gmail.com>
Subject: Re: [RFC v4 00/25] Re-use nvram module
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

On Sun, Jul 12, 2015 at 12:25 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The generic NVRAM module, drivers/char/generic_nvram, implements a
> /dev/nvram misc device. It is used only by 32-bit PowerPC platforms and
> isn't generic enough to be more widely used.

[...]

Thanks for your work!

How are we gonna merge this?
Have you looked into the dependencies?
Are there (large) parts we can merge in parallel?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
