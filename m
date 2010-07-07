Return-Path: <jacmet@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id C6CFBB6EFF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jul 2010 21:29:08 +1000 (EST)
Received: by wyb36 with SMTP id 36so2808449wyb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jul 2010 04:29:06 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH V5] powerpc/mpc512x: Add gpio driver
References: <AANLkTik7pTXHdY9_sjL9Lyz68gk2qRUs0NaGpj_7nL7K@mail.gmail.com>
	<1276245337-22897-1-git-send-email-agust@denx.de>
Date: Wed, 07 Jul 2010 13:28:53 +0200
In-Reply-To: <1276245337-22897-1-git-send-email-agust@denx.de> (Anatolij
	Gustschin's message of "Fri, 11 Jun 2010 10:35:37 +0200")
Message-ID: <87iq4r5y4q.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, Matthias Fuchs <matthias.fuchs@esd.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Anatolij" == Anatolij Gustschin <agust@denx.de> writes:

Hi,

Old mail, I know ..

 Anatolij> From: Matthias Fuchs <matthias.fuchs@esd.eu>
 Anatolij> This patch adds a gpio driver for MPC512X PowerPCs.

 Anatolij> It has been tested on our CAN-CBX-CPU5201 module that
 Anatolij> uses a MPC5121 CPU. This platform comes with a couple of
 Anatolij> LEDs and configuration switches that have been used for testing.

 Anatolij> After change to the of-gpio api the reworked driver has been
 Anatolij> tested on pdm360ng board with some configuration switches.

This looks very similar to the existing
arch/powerpc/sysdev/mpc8xxx_gpio.c - Couldn't we just add 5121 support
there instead?

 Anatolij> +struct mpc512x_gpio_regs {
 Anatolij> +	u32 gpdir;
 Anatolij> +	u32 gpodr;
 Anatolij> +	u32 gpdat;
 Anatolij> +	u32 gpier;
 Anatolij> +	u32 gpimr;
 Anatolij> +	u32 gpicr1;
 Anatolij> +	u32 gpicr2;
 Anatolij> +};

-- 
Bye, Peter Korsgaard
