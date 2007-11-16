Return-Path: <robertlazarski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by ozlabs.org (Postfix) with ESMTP id 3E4B0DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 07:44:22 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so941611nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 12:44:21 -0800 (PST)
Message-ID: <f87675ee0711161244h46c23d8byadaf1abb923b3971@mail.gmail.com>
Date: Fri, 16 Nov 2007 15:44:20 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: 85xx software reset problems from paulus.git
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <473DB6DF.9010804@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>
	<473DB6DF.9010804@anagramm.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Nov 16, 2007 10:27 AM, Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hello, Robert!
>
> robert lazarski schrieb:
>  > Hi all, on my custom 85xx board I can't do a soft reset. I'm using
>  > u-boot 1.3rc3 that has the latest cpu/mpc85xx/cpu.c patch to fix some
>  > type of reset problem. When I press the software reset button on my
>  > board after my nfs kernel panic, I get this:
>
> Please define "software reset button" in your case. :-)
> I consider a "button" clearly as hardware.
>

I mean a hardware button that calls SRESET , ie, Soft reset machine check.

<snip>
>
> The SRESET# (pin AF20) is the soft reset input, causes
> an mcp assertion to the core.... (RTFM)
>

That's what we are doing. The 85xx docs say "Soft reset. Causes a
machine check interrupt to the e500 core. Note that if the e500 core
is not configured to process machine check interrupts, the assertion
of SRESET causes a core checkstop. SRESET need not be asserted during
a hard reset."

Is the 85xx kernel "not configured to process machine check
interrupts" ? Do I need to do that myself in my boards restart
function via the special registers? Is there code already for this?

Robert
