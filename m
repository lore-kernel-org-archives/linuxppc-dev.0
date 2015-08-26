Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35CEF1A00FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 00:49:33 +1000 (AEST)
Received: by oiew67 with SMTP id w67so123130163oie.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 07:49:31 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.DEB.2.10.1508261442440.13146@digraph.polyomino.org.uk>
References: <alpine.DEB.2.10.1507021542380.29415@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1508191433380.11312@digraph.polyomino.org.uk>
 <1440026806.13406.2.camel@ellerman.id.au>
 <alpine.DEB.2.10.1508261442440.13146@digraph.polyomino.org.uk>
Date: Wed, 26 Aug 2015 16:49:30 +0200
Message-ID: <CAMuHMdWz=McFn81URtirXA4eMA4knhCfVVRLisixnxZaA46E-w@mail.gmail.com>
Subject: Re: Ping Re: [PATCH 0/8] math-emu: Update kernel math-emu code from
 current glibc soft-fp
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joseph Myers <joseph@codesourcery.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 26, 2015 at 4:44 PM, Joseph Myers <joseph@codesourcery.com> wrote:
> Ping again for the other-architecture maintainers (alpha, s390, sh,
> sparc)....

sh is orphaned, cfr. MAINTAINERS.

Perhaps the J2/J4 people are interested in maintainership?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
