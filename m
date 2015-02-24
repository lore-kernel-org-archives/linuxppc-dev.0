Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com
 [IPv6:2607:f8b0:4003:c01::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3B911A0F4F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:38:56 +1100 (AEDT)
Received: by mail-ob0-f169.google.com with SMTP id wp4so42256168obc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 01:38:54 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1424753526.2318.6.camel@ellerman.id.au>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
 <1424753526.2318.6.camel@ellerman.id.au>
Date: Tue, 24 Feb 2015 10:38:54 +0100
Message-ID: <CAMuHMdU7Tkoqe0V=feX_P85MJqNQjh7k6XCh+5ZH=zOKTAb__w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.0-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, Feb 24, 2015 at 5:52 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >   + error: book3s_64_vio_hv.c: undefined reference to `power7_wakeup_loss':  => .text+0x408)
>>
>> pseries_defconfig
>
> This one is actually from pseries_defconfig+POWERNV=n, so I think I

Thanks!

> broke your script with the + notation in the config name :)

Nope, my brain used the wrong separator.

However, my scripts do have a problem with the subdirectories
in arch/powerpc/configs/ (4xx/currituck_defconfig)...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
