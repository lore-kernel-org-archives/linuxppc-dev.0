Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id 78F98DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 23:01:36 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so5303200rvb.1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 04:01:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <499AF08B.6010702@freescale.com>
References: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>
	<20090216180857.GA18069@ld0162-tx32.am.freescale.net>
	<f234e2140902170341y31662e8fla8a8cf87473ed419@mail.gmail.com>
	<499AF08B.6010702@freescale.com>
Date: Wed, 18 Feb 2009 17:31:34 +0530
Message-ID: <f234e2140902180401u40a71642ga4e221f795bc5abd@mail.gmail.com>
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

I checked and read the
Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt and
booting-without-of.txt. It is different then what I read before from
booting-without-of.txt ... perhaps as it is old and came with BSP. Am
I right ? ? ?

> Don't specify this explicitly.  Please base new development off of the
> device tree that is in upstream Linux, not the very old tree in your BSP.

May I know the reason why I should not specify it explicitly ? ? ?
Also what would be the problem if I do in the same way as it is given
in BSP mpc8313erdb.dts ? ? ?

And should I use gpio-controller as a gpio device node ? ? ?

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam

On 2/17/09, Scott Wood <scottwood@freescale.com> wrote:
> Vijay Nikam wrote:
> > I added the gpio node as follows to mpc8313erdb.dts;
> >
> > gpio@c00 {
> >        linux,phandle = <c00>;
> >
>
> Don't specify this explicitly.  Please base new development off of the
> device tree that is in upstream Linux, not the very old tree in your BSP.
>
> >        device_type = "gpio";
> >
>
> No device_type.
>
> > The only thing I need to know what should I write at 'compatible' tag
> > ? ? ? the compatible tag format is "manufacturer,model" the
> > manufacturer is 'fsl' i.e. I think freescale but the model, as it is
> > the model number where I can find this model ? ? ? Please let me know
> > ... thanks ...
> >
>
> compatible = "fsl,mpc8313-gpio", "fsl,mpc8349-gpio";
>
> > Also I would like to ask if the above device node is written according
> > to bindings ... I think it should be right as I referred
> > 'bootingwithout-of.txt' ... but please correct me if I am worng ? ? ?
> >
>
> See also
> Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt.
>
> Also note that current Linux has a driver in
> arch/powerpc/sysdev/mpc8xxx_gpio.c.
>
> -Scott
>
