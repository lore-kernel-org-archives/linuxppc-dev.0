Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D54771A0BD8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 15:52:07 +1100 (AEDT)
Message-ID: <1424753526.2318.6.camel@ellerman.id.au>
Subject: Re: Build regressions/improvements in v4.0-rc1
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Feb 2015 15:52:06 +1100
In-Reply-To: <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXnVLtiSxqwz7ah5faPUx_8piN5eOdNKQtKNwOgT73FqA@mail.gmail.com>
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

On Mon, 2015-02-23 at 09:45 +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 23, 2015 at 9:33 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.0-rc1[1] compared to v3.19[2].
> >
> > Summarized:
> >   - build errors: +11/-10
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/head/8494/ (256 out of 257 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/head/8427/ (255 out of 257 configs)
 
...

> >   + error: book3s_64_vio_hv.c: undefined reference to `power7_wakeup_loss':  => .text+0x408)
> 
> pseries_defconfig

This one is actually from pseries_defconfig+POWERNV=n, so I think I
broke your script with the + notation in the config name :)

http://kisskb.ellerman.id.au/kisskb/buildresult/12372031/

cheers
