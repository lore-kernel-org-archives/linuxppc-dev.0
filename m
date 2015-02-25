Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415EE1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 13:44:36 +1100 (AEDT)
Message-ID: <1424832275.1459.4.camel@ellerman.id.au>
Subject: Re: Build regressions/improvements in v4.0-rc1
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Feb 2015 13:44:35 +1100
In-Reply-To: <CAMuHMdU7Tkoqe0V=feX_P85MJqNQjh7k6XCh+5ZH=zOKTAb__w@mail.gmail.com>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
 <1424753526.2318.6.camel@ellerman.id.au>
 <CAMuHMdU7Tkoqe0V=feX_P85MJqNQjh7k6XCh+5ZH=zOKTAb__w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Tue, 2015-02-24 at 10:38 +0100, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> On Tue, Feb 24, 2015 at 5:52 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> >   + error: book3s_64_vio_hv.c: undefined reference to `power7_wakeup_loss':  => .text+0x408)
> >>
> >> pseries_defconfig
> >
> > This one is actually from pseries_defconfig+POWERNV=n, so I think I
> 
> Thanks!
> 
> > broke your script with the + notation in the config name :)
> 
> Nope, my brain used the wrong separator.

I can't help with that :)

> However, my scripts do have a problem with the subdirectories
> in arch/powerpc/configs/ (4xx/currituck_defconfig)...

Yeah sorry, they are a bit of a pain. I'm sure some horrible regexp can deal
with it ;)

cheers
