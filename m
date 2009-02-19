Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id B5D3CDDDB6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 22:51:46 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so460668rvb.1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 03:51:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090218165724.GA26391@ld0162-tx32.am.freescale.net>
References: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>
	<20090216180857.GA18069@ld0162-tx32.am.freescale.net>
	<f234e2140902170341y31662e8fla8a8cf87473ed419@mail.gmail.com>
	<499AF08B.6010702@freescale.com>
	<f234e2140902180401u40a71642ga4e221f795bc5abd@mail.gmail.com>
	<20090218165724.GA26391@ld0162-tx32.am.freescale.net>
Date: Thu, 19 Feb 2009 17:21:45 +0530
Message-ID: <f234e2140902190351i41f99cbu22c3654eadf03f49@mail.gmail.com>
Subject: Re: Regarding irq_of_parse_and_map
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Because dtc will generate phandles automatically when you reference the
> node with the & operator.

Yes the same statement I found in dts-bindings for gpio txt, sorry I
missed it somehow ...

> Do you want your changes to ever make it into the upstream kernel?

Yes I would like to do that ... but the reason I asked is as it is my
first try so I am thinking that I will edit the same file and do it in
the same way ofcourse I will follow for device node gpio-controller
the new apporach and later if it works then I will create new dts with
upstream Linux base ...

Now I have created the mpc8313erdb.dts with gpio-controller device
node. I would like to ask that now I should compile it with dtc and
generate dtb and I should load this dtb on board/target, Right ? ? ?
please correct me if I am wrong ...

Also is it possible to compile device tree on Linux host and genreate
dtb for powerpc ? ? ? If yes, then how ? ? ? please let me know ...
thanks ...

Before I tried to generate virtual irq using irq_create_mapping and I
got the same number as hw_irq_no i.e. 74 as virtual irq. Also the
entry was made in proc/interrupts and trigger was 8 (Level). But when
I tried to interrupt and the handler was never called ? ? ? Was it
because of gpio device node missing in device tree ? ? ? please let me
know ... thanks ...

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam


On 2/18/09, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, Feb 18, 2009 at 05:31:34PM +0530, Vijay Nikam wrote:
> > > Don't specify this explicitly.  Please base new development off of the
> > > device tree that is in upstream Linux, not the very old tree in your BSP.
> >
> > May I know the reason why I should not specify it explicitly ? ? ?
>
> Because dtc will generate phandles automatically when you reference the
> node with the & operator.
>
> > Also what would be the problem if I do in the same way as it is given
> > in BSP mpc8313erdb.dts ? ? ?
>
> Do you want your changes to ever make it into the upstream kernel?
>
> > And should I use gpio-controller as a gpio device node ? ? ?
>
> Yes, the node should label itself as a gpio controller.
>
> -Scott
>
