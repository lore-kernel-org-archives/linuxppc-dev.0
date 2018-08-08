Return-Path: <srs0=+pp1=kx=gmail.com=geert.uytterhoeven@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lmLk1P0NzDr5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 19:29:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41lmLk0gmlz8svj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 19:29:50 +1000 (AEST)
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41lmLj365Hz9s4Z
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2018 19:29:49 +1000 (AEST)
Received: by mail-lf1-f65.google.com with SMTP id u14-v6so1112289lfu.0
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Aug 2018 02:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180727053555.26596-1-mpe@ellerman.id.au>
In-Reply-To: <20180727053555.26596-1-mpe@ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Aug 2018 11:29:32 +0200
Message-ID: <CAMuHMdVPmDG5m4C5=Y8yJYdwnWmXJJqQO1Hxa-3oncou9WCPzw@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Remove PPC32 longtrail hack in memory scan
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>, Dominik Klein <dominik.klein@gmx.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Fri, Jul 27, 2018 at 7:36 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> When the OF code was originally made common by Grant in commit
> 51975db0b733 ("of/flattree: merge early_init_dt_scan_memory() common
> code") (Feb 2010), the common code inherited a hack to handle
> PPC "longtrail" machines, which had a "memory@0" node with no
> device_type.
>
> That check was then made to only apply to PPC32 in b44aa25d20e2 ("of:
> Handle memory@0 node on PPC32 only") (May 2014).
>
> But according to Paul Mackerras the "longtrail" machines are long
> dead, if they were ever seen in the wild at all. If someone does still
> have one, we can handle this firmware wart in powerpc platform code.
>
> So remove the hack once and for all.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for your patch!

My LongTrail died in 2004.  I haven't heard since even longer about active
use from any of the other people I know that had one.

So:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

However, recently Dominik (CC) send me an enquiry about it, so perhaps
he is a happy user?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
