Return-Path: <robertlazarski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id 650AFDDE07
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 08:28:16 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so950952nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 13:28:15 -0800 (PST)
Message-ID: <f87675ee0711161328u3127de3bjdd6341cdf11cd626@mail.gmail.com>
Date: Fri, 16 Nov 2007 16:28:15 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: 85xx software reset problems from paulus.git
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>
	<473DB6DF.9010804@anagramm.de>
	<f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Nov 16, 2007 3:44 PM, robert lazarski <robertlazarski@gmail.com> wrote:
> On Nov 16, 2007 10:27 AM, Clemens Koller <clemens.koller@anagramm.de> wrote:
> > The SRESET# (pin AF20) is the soft reset input, causes
> > an mcp assertion to the core.... (RTFM)
> >
>
> That's what we are doing. The 85xx docs say "Soft reset. Causes a
> machine check interrupt to the e500 core. Note that if the e500 core
> is not configured to process machine check interrupts, the assertion
> of SRESET causes a core checkstop. SRESET need not be asserted during
> a hard reset."
>

Sorry for replying to myself, but thought I'd mention SRESET works
fine on 85xx 2.6.23 , ie, the board resets after kernel panic. It
doesn't work for me on 2.6.24rc2 .

Robert
