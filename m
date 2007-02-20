Return-Path: <netstv@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.238])
	by ozlabs.org (Postfix) with ESMTP id 0AB99DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 02:29:48 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so2097057wxd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 07:29:47 -0800 (PST)
Message-ID: <b4b98b690702200729g389fb77fr488ce2404566ace0@mail.gmail.com>
Date: Tue, 20 Feb 2007 07:29:47 -0800
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: ami@waves.com
Subject: Re: 8541E and vector table.
In-Reply-To: <002d01c754fd$1f030860$0600000a@waves.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <b4b98b690702200620q3c70cba9j2d8046d4451686a1@mail.gmail.com>
	<002d01c754fd$1f030860$0600000a@waves.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ami,

Thanks for the reply.  Yes I have the manual.  I guess I need to be a
little more specific.  I usually don't get down to this level of the
hardware.  It usually just works for me.

I have all the explinations etc.. of each vector, but in my memory, I
can't figure out how to map 0x0000_0700 to one of the SPR's.  I think
that's what I want to know. :)

-stv

On 2/20/07, Ami Levi Waves <ami@waves.com> wrote:
> Download the MPC8541 reference manual from Freescale web site.
> Look in the chapter that says Exceptions (could be chapter 6)
> You'll fine the different vectors addresses + explanations about each
> vector.
>
> Ami
>
> > -----Original Message-----
> > From: linuxppc-embedded-bounces+ami=waves.com@ozlabs.org [mailto:linuxppc-
> > embedded-bounces+ami=waves.com@ozlabs.org] On Behalf Of Steve Iribarne
> > (GMail)
> > Sent: Tuesday, February 20, 2007 3:21 PM
> > To: linuxppc-embedded
> > Subject: 8541E and vector table.
> >
> > Hi.
> >
> > I must admit, this stuff always baffles me a bit, so I need someone
> > who knows this to explain it to me.
> >
> > I am using an 8541E and my system randomly crashes.  By randomly, I
> > mean at different times.  I have a BDI hooked up and it always jumps
> > to offset 0x0000_0700
> >
> > I believe this to be a vector table offset, but I need to figure out
> > which interrupt it is.  I believe this is a hardware issued, because
> > if I look at that value, it looks to be default values.  In other
> > words, I don't believe I have it setup.
> >
> > So the question I have is how do I figure out what that interrupt vector
> > is?
> >
> > Thanks so much.
> >
> > -stv
> >
> > --
> > /*
> >  * Steve Iribarne
> >  * Software Engineer
> >  * (aka Grunt)
> >  */
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>


-- 
/*
 * Steve Iribarne
 * Software Engineer
 * (aka Grunt)
 */
