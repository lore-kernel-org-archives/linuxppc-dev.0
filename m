Return-Path: <robertlazarski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id 551CFDDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 07:34:45 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so181156nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 14:34:43 -0700 (PDT)
Message-ID: <f87675ee0708161434i9f38b0dg123a767822cf7402@mail.gmail.com>
Date: Thu, 16 Aug 2007 17:34:42 -0400
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: external IRQ's
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <46C47A1D.5030303@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87675ee0708160751u14f96dbcs3ad35a147b70a3f3@mail.gmail.com>
	<46C47A1D.5030303@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/16/07, Scott Wood <scottwood@freescale.com> wrote:
> robert lazarski wrote:
> > 1) Do I need to define those external IRQ's in both a device tree file
> > under arch/powerpc/boot/dts and also in C code under
> > arch/powerpc/platforms/85xx ?
>
> Just in the dts.

Thanks, I notice in 2.6.23-rc3 there no longer are a series of
mpic_assign_isu() .

>
> I don't know what version of the dts you're looking at, but the one in
> the current Linux tree has <5 1>, not <35 0>.

Thanks for pointing that out! 2.6.22.2 has 35 as the interrupt, while
2.6.23-rc3 has 5. 35 didn't make any sense to me since the old ppc
arch used 5.

>
> > I'm also not getting the ethernet interrupts in the above cds example:
> >
> > interrupts = <d 2 e 2 12 2>;
> >
> > Why start with 'd' and 'e' ?  I noticed many if not all boards do that.
>
> In the current dts, it's <1d 2 1e 2 22 2>.
>
> It appears that the interrupt numbering was changed not too long ago,
> and that external interrupts used to be numbered above the internal ones.
>
> -Scott
>

Why <1d 2 1e 2 22 2> ? I can't seem to parse these numbers - how do I
know what to use for my external interupts 1,2 for phy's 0,1 using a
88E1121R and for external interupts 3,4 for phy's 2,3 using a 88E1111
?

Thanks!
Robert
