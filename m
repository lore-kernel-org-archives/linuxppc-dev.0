Return-Path: <zoolur@gmail.com>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218]) by ozlabs.org (Postfix) with ESMTP id 22A81B7D20
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 20:51:46 +1100 (EST)
Received: by fxm10 with SMTP id 10so2534642fxm.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 01:51:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201002081913.57920.sr@denx.de>
References: <8f56d5201002080837j49a38201vccefdf04382f98a3@mail.gmail.com>
	<201002081913.57920.sr@denx.de>
Date: Tue, 9 Feb 2010 15:21:43 +0530
Message-ID: <8f56d5201002090151v5d116ba3r4383368069bb4bc@mail.gmail.com>
Subject: Re: [ELDK] GPIO pin in interrupt handler/AMCC processor
From: Zoolu R <zoolur@gmail.com>
To: Stefan Roese <sr@denx.de>
Content-Type: multipart/alternative; boundary=001485f27fae7c8cc7047f27ddc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485f27fae7c8cc7047f27ddc1
Content-Type: text/plain; charset=ISO-8859-1

Hi Stefan,

thanks for you reply, as per Amcc 440 ep h/w spec . I can see 10 External
interrupts can be configured !! So can i use the GPIO ping mapped to one of
these external IRQ's ? Or should the h/w deisgn  also support it  or is it
pure s/w configurations. So i would just like to get an indication via
interrupt when status is changed (0/1). I would like to do this is linux.

Are there any reference drivers for this ? how to go about it ?

Thanks & Regards
Zoolu
On Mon, Feb 8, 2010 at 11:43 PM, Stefan Roese <sr@denx.de> wrote:

> Hi Zoolu,
>
> first, this question is not ELDK related. You should send it to Linux-PPC
> mailing list instead <linuxppc-dev@ozlabs.org>. But still here a few quick
> answers/comments.
>
> On Monday 08 February 2010 17:37:20 Zoolu R wrote:
> > We are using a target with AMCC 440ep processor. We need to read the a
> GPIO
> > pin  value in a interrupt mode in linux kernel. Is there some modules
> where
> > i can refer so some generic implementation(configuring gpio pin as
> >  inteerupt pin and handlling the same).
>
> The PPC4xx GPIO support is available in the current Linux kernel. See:
>
> arch/powerpc/sysdev/ppc4xx_gpio.c
>
> for more details. Please note that you also need to write a GPIO device
> node
> in the device tree source (dts) of your Linux port. See this file for
> details
> in the GPIO node:
>
> arch/powerpc/boot/dts/warp.dts
>
> >  I would like to detect the dynamic
> >  value change(0/1) using interrupt and perform isr_call back. Could some
> >  one show me some pointers.
>
> So you don't want to use the GPIO pin functionality, but the external
> interrupt functionality (the pin functions are multiplexed). You need to
> write
> a device driver for your custom device. And you need to configure the pin
> as
> external interrupt and again add a device node including the interrupt
> description into your device tree source (dts).
>
> Cheers,
> Stefan
>
> --
> DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
>

--001485f27fae7c8cc7047f27ddc1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi Stefan,</div>
<div>=A0</div>
<div>thanks for you reply, as per Amcc 440 ep h/w spec=A0. I can see 10 Ext=
ernal interrupts can be configured !! So can i use the GPIO ping mapped to =
one of these external IRQ&#39;s ? Or should the h/w deisgn =A0also support =
it =A0or is it pure s/w configurations. So i would just like to get an indi=
cation via interrupt when status is changed (0/1). I would like to do this =
is linux.</div>

<div>=A0</div>
<div>Are there any reference drivers for this ? how to go about it ?</div>
<div>=A0</div>
<div>Thanks &amp; Regards</div>
<div>Zoolu<br></div>
<div class=3D"gmail_quote">On Mon, Feb 8, 2010 at 11:43 PM, Stefan Roese <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:sr@denx.de">sr@denx.de</a>&gt;</span>=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Zoolu,<br><br>first, this que=
stion is not ELDK related. You should send it to Linux-PPC<br>mailing list =
instead &lt;<a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.=
org</a>&gt;. But still here a few quick<br>
answers/comments.<br>
<div class=3D"im"><br>On Monday 08 February 2010 17:37:20 Zoolu R wrote:<br=
>&gt; We are using a target with AMCC 440ep processor. We need to read the =
a GPIO<br>&gt; pin =A0value in a interrupt mode in linux kernel. Is there s=
ome modules where<br>
&gt; i can refer so some generic implementation(configuring gpio pin as<br>=
&gt; =A0inteerupt pin and handlling the same).<br><br></div>The PPC4xx GPIO=
 support is available in the current Linux kernel. See:<br><br>arch/powerpc=
/sysdev/ppc4xx_gpio.c<br>
<br>for more details. Please note that you also need to write a GPIO device=
 node<br>in the device tree source (dts) of your Linux port. See this file =
for details<br>in the GPIO node:<br><br>arch/powerpc/boot/dts/warp.dts<br>

<div class=3D"im"><br>&gt; =A0I would like to detect the dynamic<br>&gt; =
=A0value change(0/1) using interrupt and perform isr_call back. Could some<=
br>&gt; =A0one show me some pointers.<br><br></div>So you don&#39;t want to=
 use the GPIO pin functionality, but the external<br>
interrupt functionality (the pin functions are multiplexed). You need to wr=
ite<br>a device driver for your custom device. And you need to configure th=
e pin as<br>external interrupt and again add a device node including the in=
terrupt<br>
description into your device tree source (dts).<br><br>Cheers,<br>Stefan<br=
><font color=3D"#888888"><br>--<br>DENX Software Engineering GmbH, =A0 =A0 =
=A0MD: Wolfgang Denk &amp; Detlev Zundel<br>HRB 165235 Munich, =A0Office: K=
irchenstr.5, D-82194 Groebenzell, Germany<br>
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: <a href=3D"mailto=
:office@denx.de">office@denx.de</a><br></font></blockquote></div><br>

--001485f27fae7c8cc7047f27ddc1--
