Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.206])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta8.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 94D612C034B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 06:25:57 +1100 (EST)
In-Reply-To: <CAMuHMdUOUf7shC9A+enCt8qQygG=Qw_soeNJnTWQKr90o2gZhA@mail.gmail.com>
References: <20131103210748.E74FAE06C0@canberra.localdomain>
 <CAMuHMdUOUf7shC9A+enCt8qQygG=Qw_soeNJnTWQKr90o2gZhA@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF94C4BD90.0FA79EFF-ONCA257C19.0069FFD4-CA257C19.006A19F0@csc.com>
Date: Tue, 5 Nov 2013 05:18:55 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: geert.uytterhoeven@gmail.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

geert.uytterhoeven@gmail.com wrote on 11/04/2013 06:59:21 PM:

> From: Geert Uytterhoeven <geert@linux-m68k.org>
> To: Stephen N Chivers/AUS/CSC@CSC
> Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
> Date: 11/04/2013 06:59 PM
> Subject: Re: [PATCH v3 1/1] powerpc/embedded6xx: Add support for 
> Motorola/Emerson MVME5100
> Sent by: geert.uytterhoeven@gmail.com
> 
> On Sun, Nov 3, 2013 at 10:07 PM, Stephen Chivers <schivers@csc.com> 
wrote:
> > +++ b/arch/powerpc/boot/dts/mvme5100.dts
> > @@ -0,0 +1,185 @@
> > +/*
> > + * Device Tree Souce for Motorola/Emerson MVME5100.
> 
> Source
Ok. Thanks, will be fixed.
> 
> (unless this expresses your personal appreciation for device trees ;-)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- 
> geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. 
But
> when I'm talking to journalists I just say "programmer" or somethinglike 
that.
>                                 -- Linus Torvalds
