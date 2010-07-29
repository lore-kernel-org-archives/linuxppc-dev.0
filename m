Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 74549B6EF3
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 17:19:44 +1000 (EST)
Received: by iwn36 with SMTP id 36so44277iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 00:19:43 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <87iq4r5y4q.fsf@macbook.be.48ers.dk>
References: <AANLkTik7pTXHdY9_sjL9Lyz68gk2qRUs0NaGpj_7nL7K@mail.gmail.com>
	<1276245337-22897-1-git-send-email-agust@denx.de>
	<87iq4r5y4q.fsf@macbook.be.48ers.dk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 29 Jul 2010 01:19:23 -0600
Message-ID: <AANLkTi=drdEQG7n8c2-UniYtY0g64kzkY-Oy_uD7iCBG@mail.gmail.com>
Subject: Re: [PATCH V5] powerpc/mpc512x: Add gpio driver
To: Peter Korsgaard <jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Matthias Fuchs <matthias.fuchs@esd.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 7, 2010 at 5:28 AM, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>>>>> "Anatolij" =3D=3D Anatolij Gustschin <agust@denx.de> writes:
>
> Hi,
>
> Old mail, I know ..
>
> =A0Anatolij> From: Matthias Fuchs <matthias.fuchs@esd.eu>
> =A0Anatolij> This patch adds a gpio driver for MPC512X PowerPCs.
>
> =A0Anatolij> It has been tested on our CAN-CBX-CPU5201 module that
> =A0Anatolij> uses a MPC5121 CPU. This platform comes with a couple of
> =A0Anatolij> LEDs and configuration switches that have been used for test=
ing.
>
> =A0Anatolij> After change to the of-gpio api the reworked driver has been
> =A0Anatolij> tested on pdm360ng board with some configuration switches.
>
> This looks very similar to the existing
> arch/powerpc/sysdev/mpc8xxx_gpio.c - Couldn't we just add 5121 support
> there instead?
>
> =A0Anatolij> +struct mpc512x_gpio_regs {
> =A0Anatolij> + =A0 =A0u32 gpdir;
> =A0Anatolij> + =A0 =A0u32 gpodr;
> =A0Anatolij> + =A0 =A0u32 gpdat;
> =A0Anatolij> + =A0 =A0u32 gpier;
> =A0Anatolij> + =A0 =A0u32 gpimr;
> =A0Anatolij> + =A0 =A0u32 gpicr1;
> =A0Anatolij> + =A0 =A0u32 gpicr2;
> =A0Anatolij> +};

Hi Anatolij,

Peter's right, the register map looks the same, except for the
additional gpicr1 & 2 registers in the 512x version.  Can the 512x
gpios be supported by the 8xxx gpio driver?

g.
