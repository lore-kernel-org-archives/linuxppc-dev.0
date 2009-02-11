Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id B2CC1DDDAE
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 21:13:28 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so72613rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 02:13:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1234346072.9778.20.camel@localhost>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
	<1234343703.9778.13.camel@localhost>
	<f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
	<1234346072.9778.20.camel@localhost>
Date: Wed, 11 Feb 2009 15:43:26 +0530
Message-ID: <f234e2140902110213g3ae48f2es9fe41087bc8c7b39@mail.gmail.com>
Subject: Re: request_irq return errno 38
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok ... so that means if I am writing driver for any device I need to
take care of this mapping ? ? ? I mean I should use virq ? ? ?

I read in LDD book, they give directly irq no. they have given
parallel port example, here they have set or said irq no. defaults to
7 and they have not done any irq_mapping so what is the difference ? ?
? I mean how I should know when to use irq_mapping and when not ? ? ?

Also is it some difference between writng drivers on embedded Linux
level and Linux PC (i386) ? ? ?

Sorry for perhaps these basic questions as kind of new to Linux kernel
programming ... :-)

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam


On 2/11/09, Michael Ellerman <michael@ellerman.id.au> wrote:
> On Wed, 2009-02-11 at 15:11 +0530, Vijay Nikam wrote:
> > Thanks for your prompt reply ...
> >
> > I am using kernel version 2.6.20 ...
>
> OK, that kernel has the irq remapping stuff.
>
> > May I know what raw IRQ means ? ? ? and what is the reason I cant map
> > raw_irq_number ???
>
> Sorry, that's not the best terminology.
>
> I guess the right name is hardware irq number.
>
> You can't map it because the kernel keeps a mapping between hardware irq
> numbers and virtual irq numbers. request_irq() expects a virtual irq
> number.
>
> cheers
>
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>
> wwweb: http://michael.ellerman.id.au
> phone:  +61 2 6212 1183  (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
>
>
