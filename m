Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BB6FFDDDD8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 17:42:37 +1100 (EST)
Date: Tue, 21 Oct 2008 08:42:36 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: [REGRESSION 2.6.27] i2c-mpc not probing on linkstation (was Re:
	[PATCH] powerpc: enable heap randomization for linkstations)
In-Reply-To: <9e4733910810200519w4689131dv73bf3539c53d2bea@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0810210832260.4941@axis700.grange>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
	<9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
	<Pine.LNX.4.64.0810192347250.21665@axis700.grange>
	<9e4733910810191505u3ec1db0dl25e87bf3b78c740d@mail.gmail.com>
	<Pine.LNX.4.64.0810200022040.21665@axis700.grange>
	<9e4733910810191540p1000c28l89ca50794addae37@mail.gmail.com>
	<Pine.LNX.4.64.0810200754550.3941@axis700.grange>
	<9e4733910810200519w4689131dv73bf3539c53d2bea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 20 Oct 2008, Jon Smirl wrote:

> On Mon, Oct 20, 2008 at 1:55 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Sun, 19 Oct 2008, Jon Smirl wrote:
> >
> >> Is i2c-mpc built into your kernel? It's not going to module auto-load
> >> because the names don't match - fsl-i2c and i2c-mpc.
> >
> > It is built into the kernel.
> 
> Put a printk in it's init function to make sure it is initializing.

I don't need that, I see it here:

/sys/bus/of_platform/drivers/mpc-i2c

> Next thing I do is put printks over in arch/powerpc/.. to tell me
> which strings from the device tree are being looked for.
> 
> You can also look in /proc/device_tree and make sure fsl-i2c is in there.
> 
> When you find the problem is will probably be something simple like a
> mismatch between _ and -. I have been down this path before and spent
> a day figuring out why a module wouldn't load and it was a simple
> typo.

Thanks, I know, that I can find the reason and, probably, a fix after a 
day of printk debugging. The thing is - I don't have this day, and I am 
sure there are people on this list, who can spot and fix the problem 
within minutes, that's why I posted it here after I realised, that 2 hours 
of me searching for the problem didn't bring any result.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
