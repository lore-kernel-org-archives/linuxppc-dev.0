Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id A42A5DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 09:18:11 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3343191wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Nov 2007 14:18:09 -0800 (PST)
Message-ID: <9e4733910711071418u5914f188nffc7ab50e62cc88e@mail.gmail.com>
Date: Wed, 7 Nov 2007 17:18:09 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
In-Reply-To: <4732396D.4040904@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
	<4732396D.4040904@genesi-usa.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/7/07, Matt Sealey <matt@genesi-usa.com> wrote:
> Jon Smirl wrote:
> > Sometimes the fsl prefix is being used and sometimes it isn't. Look at
> > the two compatible strings. Which way is it going to be? Is
> > fsl,has-wdt right?
>
> fsl,has-wdt is right, at least since someone changed it.

What's the story with compatible?
I would think the gdt entries are wrong.

               gpt@600 {       // General Purpose Timer
                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";

code in drivers/watchdog/mpc5200_wdt.c would need to be changed to.

drivers/watchdog/mpc5200_wdt.c: { .compatible = "fsl,mpc5200-gpt", },

-- 
Jon Smirl
jonsmirl@gmail.com
