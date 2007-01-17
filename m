Return-Path: <netstv@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.233])
	by ozlabs.org (Postfix) with ESMTP id 2A31EDDF53
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 11:29:59 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so1761497wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Jan 2007 16:29:58 -0800 (PST)
Message-ID: <b4b98b690701161629q73b7a4c8j10bf842805cf299f@mail.gmail.com>
Date: Tue, 16 Jan 2007 16:29:58 -0800
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "agnel juni" <junijoseph@yahoo.co.in>
Subject: Re: PCI IRQ -MPC8540
In-Reply-To: <20070116232034.40662.qmail@web8414.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070116232034.40662.qmail@web8414.mail.in.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is this the pin used for the external messaging?


On 1/16/07, agnel juni <junijoseph@yahoo.co.in> wrote:
>
> Hello all:
>
> I would like to understand if there is a way to program the PCI interrupt
> pin register of MPC8540. I did look for this in the datasheet, but couldn't
> find any positive answer.
>
> Currently, I am working in a set-up where MPC8540 is an agent, plugged into
> the PC host.
> I couldn't get an IRQ for the card when plugged in some PCI slots, whereas
> in one of the slots I do see a non-zero value.
>
> It would be great if you could help me understand the issue.
>
> I am sorry if the question is inapporpriate in the group. I am desperate to
> solve the issue.
>
> Thanks for any help.
> J.Joseph
>
> ----- Original Message ----
> From: Kumar Gala <galak@kernel.crashing.org>
> To: Wang Matthew-R59995 <Qi.W@freescale.com>
> Cc: linuxppc-embedded@ozlabs.org
> Sent: Wednesday, 18 October, 2006 6:54:24 PM
> Subject: Re: Linuxppc-embedded Digest, Vol 26, Issue 36
>
>
> On Oct 18, 2006, at 8:10 PM, Wang Matthew-R59995 wrote:
>
> > Hi Kumar,
> >
> > Actually I do many trials about it. Vxwerks Bootrom is smaller than
> > U-Boot. The key difference between Bootrom and U-boot is that some
> > source code of Bootrom is invisible to the users.
> >
> > Actually the rfi instruction which I point out is the first rfi
> > instruction of Linux PowerPC bringup.
> >
> > Before that, it's TLB entry invalidation and temp TLB entry mapping.
> >
> > I check MMU setting carefully before coming Linux Kernel.
> >
> > I just want to know if other guys met similar scenario like me. I
> > don't
> > need the precise answer, just overall suggestion about it because I
> > understand that not everyone has the same bootloader of mine, that
> > bootloader is actually a customized bootloader.
>
> I understand that, thus I was asking what exact problem you were
> seeing to try and help.
>
> > Anyway thank you.
> >
> > R9 point to LR register, mask the high 20 bit of r9 and send to r7,
> > and
> > then add 24, which means stride 6 instructions for rfi instruction
> > execution.
> >
> > Of course, rfi can switch the TLB entry, both the previous TLB
> > entry and
> > the temp TLB entry point to the same physical address.
> >
> > I've checked it.
>
> I know what the code does, I wrote it :)
>
> - kumar
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>  ________________________________
>  Here's a new way to find what you're looking for - Yahoo! Answers
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>


-- 
/*
 * Steve Iribarne
 * Software Engineer
 * (aka Grunt)
 */
