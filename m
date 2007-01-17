Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE9D9DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 12:57:18 +1100 (EST)
In-Reply-To: <20070117015413.28659.qmail@web8407.mail.in.yahoo.com>
References: <20070117015413.28659.qmail@web8407.mail.in.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <5C902FB2-CF5C-466A-B7AF-8D0B4BFA1A25@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI IRQ -MPC8540
Date: Tue, 16 Jan 2007 19:56:20 -0600
To: agnel juni <junijoseph@yahoo.co.in>
Cc: "linuxppc-embedded@ozlabs.org \(\(\(\(E-Mail\)\)\)\)"
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What kinda of interrupt do you want on IRQ_OUT/INTA?

- k

On Jan 16, 2007, at 7:54 PM, agnel juni wrote:

> Yes IRQ_OUT is wired to INTA.
>
> Could you please advise on how to generate interrupt for this.
>
> Thanks
> J-
>
> ----- Original Message ----
> From: Kumar Gala <galak@kernel.crashing.org>
> To: agnel juni <junijoseph@yahoo.co.in>
> Cc: linuxppc-embedded@ozlabs.org
> Sent: Tuesday, 16 January, 2007 5:29:01 PM
> Subject: Re: PCI IRQ -MPC8540
>
>
> On Jan 16, 2007, at 5:20 PM, agnel juni wrote:
>
> > Hello all:
> >
> > I would like to understand if there is a way to program the PCI
> > interrupt pin register of MPC8540. I did look for this in the
> > datasheet, but couldn't find any positive answer.
> >
> > Currently, I am working in a set-up where MPC8540 is an agent,
> > plugged into the PC host.
> > I couldn't get an IRQ for the card when plugged in some PCI slots,
> > whereas in one of the slots I do see a non-zero value.
> >
> > It would be great if you could help me understand the issue.
> >
> > I am sorry if the question is inapporpriate in the group. I am
> > desperate to solve the issue.
> >
> > Thanks for any help.
>
> You need to find out how the PCI edge interrupts are wired on you
> board than we can talk about how to generate an interrupt based on
> that.  I'd guess IRQ_OUT is wired to INTA, but it would be good to
> verify that.
>
> - k
>
> > J.Joseph
> >
> > ----- Original Message ----
> > From: Kumar Gala <galak@kernel.crashing.org>
> > To: Wang Matthew-R59995 <Qi.W@freescale.com>
> > Cc: linuxppc-embedded@ozlabs.org
> > Sent: Wednesday, 18 October, 2006 6:54:24 PM
> > Subject: Re: Linuxppc-embedded Digest, Vol 26, Issue 36
> >
> >
> > On Oct 18, 2006, at 8:10 PM, Wang Matthew-R59995 wrote:
> >
> > > Hi Kumar,
> > >
> > > Actually I do many trials about it. Vxwerks Bootrom is smaller =20
> than
> > > U-Boot. The key difference between Bootrom and U-boot is that some
> > > source code of Bootrom is invisible to the users.
> > >
> > > Actually the rfi instruction which I point out is the first rfi
> > > instruction of Linux PowerPC bringup.
> > >
> > > Before that, it's TLB entry invalidation and temp TLB entry =20
> mapping.
> > >
> > > I check MMU setting carefully before coming Linux Kernel.
> > >
> > > I just want to know if other guys met similar scenario like me. I
> > > don't
> > > need the precise answer, just overall suggestion about it =20
> because I
> > > understand that not everyone has the same bootloader of mine, that
> > > bootloader is actually a customized bootloader.
> >
> > I understand that, thus I was asking what exact problem you were
> > seeing to try and help.
> >
> > > Anyway thank you.
> > >
> > > R9 point to LR register, mask the high 20 bit of r9 and send to =20=

> r7,
> > > and
> > > then add 24, which means stride 6 instructions for rfi instruction
> > > execution.
> > >
> > > Of course, rfi can switch the TLB entry, both the previous TLB
> > > entry and
> > > the temp TLB entry point to the same physical address.
> > >
> > > I've checked it.
> >
> > I know what the code does, I wrote it :)
> >
> > - kumar
> >
> >
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> > Here=92s a new way to find what you're looking for - Yahoo! Answers
>
>
>
> Here=92s a new way to find what you're looking for - Yahoo! Answers
