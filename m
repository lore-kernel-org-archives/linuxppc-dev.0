Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pz0-f175.google.com (mail-pz0-f175.google.com
	[209.85.222.175]) by ozlabs.org (Postfix) with ESMTP id 07090B7B7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 20:52:26 +1000 (EST)
Received: by pzk5 with SMTP id 5so496086pzk.18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 03:52:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y6o6rvvc.fsf@macbook.be.48ers.dk>
References: <cb9ecdfa0909222055x1d691698sb516b5b8f5f81d@mail.gmail.com>
	<87y6o6rvvc.fsf@macbook.be.48ers.dk>
Date: Wed, 23 Sep 2009 18:52:24 +0800
Message-ID: <cb9ecdfa0909230352w77a37f59h3c7f1e146121f9f6@mail.gmail.com>
Subject: Re: GPIO driver for MPC8313.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks, got it. BTW, how to trigger GPIO level in user space
application? I also found arch/powerpc/platforms/52xx/mpc52xx_gpio.c
is a good example. Any reply is appreciate.

BRs, H. Johnny

2009/9/23 Peter Korsgaard <jacmet@sunsite.dk>:
>>>>>> "Johnny" =3D=3D Johnny Hung <johnny.hacking@gmail.com> writes:
>
> =A0Johnny> Hi All:
> =A0Johnny> =A0 =A0Is there a alreday written GPIO dirver or example for
> =A0Johnny> MPC8313/similar ppc platform. It looks like many people need G=
PIO
> =A0Johnny> dirver to control LED, etc... I think is it possible to write =
a
> =A0Johnny> general gpio driver for all ppc platform and only need to modi=
fy gpio
> =A0Johnny> iomap information of dtb file. Please give me a advice. Thanks=
 in
> =A0Johnny> advanced.
>
> Sure, it's arch/powerpc/sysdev/mpc8xxx_gpio.c, included since 2.6.28. To
> use it, simply enable CONFIG_MPC8xxx_GPIO and add a gpio-controller node
> to your dts, similar to how it's done in
> arch/powerpc/boot/dts/mpc837*_rdb.dts.
>
> See Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt for details of
> the dts bindings.
>
> --
> Bye, Peter Korsgaard
>
