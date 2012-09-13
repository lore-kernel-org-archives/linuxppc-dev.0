Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 776842C00B8
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2012 17:50:24 +1000 (EST)
Message-ID: <1347522605.2276.25.camel@pasglop>
Subject: Re: [PATCH] add GXT4000P and GXT6500P support to the gxt4500 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Sep 2012 17:50:05 +1000
In-Reply-To: <CAMuHMdU2vahGBej+3Q8eBpmn1c7kU3hb1Ez4hGdY1Upn1qsygQ@mail.gmail.com>
References: <1347452412-7129-1-git-send-email-dan@danny.cz>
 <1347494498.2276.19.camel@pasglop>
 <CAMuHMdU2vahGBej+3Q8eBpmn1c7kU3hb1Ez4hGdY1Upn1qsygQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Dan =?ISO-8859-1?Q?Hor=E1k?= <dan@danny.cz>, linuxppc-dev@ozlabs.org,
 Nico Macrionitis <acrux@cruxppc.org>, Giuseppe Coviello <cjg@cruxppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-09-13 at 07:01 +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 13, 2012 at 2:01 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2012-09-12 at 14:20 +0200, Dan Horák wrote:
> >> I'm reviving an old patch from 2009 that adds support for GXT4000P and GXT6500P
> >> adapter to the gxt4500 driver.
> >
> > Who is the original author ?
> 
> Signed-off-by: Nico Macrionitis <acrux@cruxppc.org>
> Signed-off-by: Giuseppe Coviello <cjg@cruxppc.org>
> 
> It even has your ack (albeit not in canonical form ;-), cfr.

Well, the submission had no From: line matching the top S-O-B so I'm not
sure who actually wrote the patch :-)

Cheers,
Ben

> >> See threads at http://marc.info/?l=linux-fbdev-devel&m=124345080216952&w=2
> >> and https://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072672.html
> >> for more details.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
