Return-Path: <dan@danny.cz>
Received: from smtpout1-pesd.core.ignum.cz (smtpout1-pesd.core.ignum.cz
 [62.109.128.57]) by ozlabs.org (Postfix) with ESMTP id A604E2C0087
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2012 19:37:32 +1000 (EST)
Message-ID: <1347528729.2583.27.camel@eagle.danny.cz>
Subject: Re: [PATCH] add GXT4000P and GXT6500P support to the gxt4500 driver
From: Dan =?ISO-8859-1?Q?Hor=E1k?= <dan@danny.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Sep 2012 11:32:09 +0200
In-Reply-To: <1347522605.2276.25.camel@pasglop>
References: <1347452412-7129-1-git-send-email-dan@danny.cz>
 <1347494498.2276.19.camel@pasglop>
 <CAMuHMdU2vahGBej+3Q8eBpmn1c7kU3hb1Ez4hGdY1Upn1qsygQ@mail.gmail.com>
 <1347522605.2276.25.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nico Macrionitis <acrux@cruxppc.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Giuseppe Coviello <cjg@cruxppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt píše v Čt 13. 09. 2012 v 17:50 +1000: 
> On Thu, 2012-09-13 at 07:01 +0200, Geert Uytterhoeven wrote:
> > On Thu, Sep 13, 2012 at 2:01 AM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > On Wed, 2012-09-12 at 14:20 +0200, Dan Horák wrote:
> > >> I'm reviving an old patch from 2009 that adds support for GXT4000P and GXT6500P
> > >> adapter to the gxt4500 driver.
> > >
> > > Who is the original author ?
> > 
> > Signed-off-by: Nico Macrionitis <acrux@cruxppc.org>
> > Signed-off-by: Giuseppe Coviello <cjg@cruxppc.org>
> > 
> > It even has your ack (albeit not in canonical form ;-), cfr.
> 
> Well, the submission had no From: line matching the top S-O-B so I'm not
> sure who actually wrote the patch :-)

it must be one of the guys in S-O-B, I have only volunteered to resubmit
it to get it finally included in mainline


Dan

> Cheers,
> Ben
> 
> > >> See threads at http://marc.info/?l=linux-fbdev-devel&m=124345080216952&w=2
> > >> and https://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072672.html
> > >> for more details.
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> 
> 
> 
