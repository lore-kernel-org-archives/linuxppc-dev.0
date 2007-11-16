Return-Path: <robertlazarski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by ozlabs.org (Postfix) with ESMTP id 6BB65DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 09:01:35 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so957593nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 14:01:33 -0800 (PST)
Message-ID: <f87675ee0711161401k600b658ao3d6ae572fb367c47@mail.gmail.com>
Date: Fri, 16 Nov 2007 17:01:32 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: 85xx software reset problems from paulus.git
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <0B4C1069-9D89-44E8-89F7-9E7CE07B03DF@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>
	<473DB6DF.9010804@anagramm.de>
	<f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>
	<f87675ee0711161328u3127de3bjdd6341cdf11cd626@mail.gmail.com>
	<0B4C1069-9D89-44E8-89F7-9E7CE07B03DF@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Nov 16, 2007 4:46 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
>
> On Nov 16, 2007, at 3:28 PM, robert lazarski wrote:
>
> > On Nov 16, 2007 3:44 PM, robert lazarski <robertlazarski@gmail.com>
> > wrote:
> >> On Nov 16, 2007 10:27 AM, Clemens Koller
> >> <clemens.koller@anagramm.de> wrote:
> >>> The SRESET# (pin AF20) is the soft reset input, causes
> >>> an mcp assertion to the core.... (RTFM)
> >>>
> >>
> >> That's what we are doing. The 85xx docs say "Soft reset. Causes a
> >> machine check interrupt to the e500 core. Note that if the e500 core
> >> is not configured to process machine check interrupts, the assertion
> >> of SRESET causes a core checkstop. SRESET need not be asserted during
> >> a hard reset."
> >>
> >
> > Sorry for replying to myself, but thought I'd mention SRESET works
> > fine on 85xx 2.6.23 , ie, the board resets after kernel panic. It
> > doesn't work for me on 2.6.24rc2 .
>
> What actual 85xx are you using?
>
> - k
>

Custom 8548 board. I'm using the cds 85xx code for a reference and I
calling the same reset functions.

Robert
