Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5C2452C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 03:27:48 +1100 (EST)
Message-ID: <1364398023.11644.42.camel@pasglop>
Subject: Re: [PATCH] powerpc: remove PReP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Mar 2013 16:27:03 +0100
In-Reply-To: <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
References: <1363864206.1390.117.camel@x61.thuisdomein>
 <20130322042159.GC26908@concordia>
 <1364381223.1345.18.camel@x61.thuisdomein>
 <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Bolle <pebolle@tiscali.nl>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Rob Landley <rob@landley.net>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, Adam Belay <abelay@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-03-27 at 13:05 +0100, Geert Uytterhoeven wrote:
> On Wed, Mar 27, 2013 at 11:47 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > 3) I removed two files in documentation that are almost entirely PReP
> > specific. The remaining lines looked uninteresting.
> 
> > --- a/Documentation/powerpc/sound.txt
> > +++ /dev/null
> 
> > -2. IBM CHRP
> > -
> > -  I have only tested this on the 43P-150.  Build the kernel with the cs4232
> > -  set as a module and load the module with irq=9 dma=1 dma2=2 io=0x550
> 
> This section is CHRP-specific. The cs4232 driver also worked on the
> CHRP LongTrail.
> But I don't remember if the parameter values above also applied to LongTrail.
> I do remember it didn't work without specifing the right parameters, so you
> probably want to keep this section.

Isn't LongTrail support LongDead ? Can we still boot these things at
all ? Anybody still has a functional one ?

Cheers,
Ben.

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
