Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 6AA1EDDFFC
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 16:41:20 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so919958wag.13
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 21:41:18 -0800 (PST)
Message-ID: <9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>
Date: Thu, 10 Jan 2008 00:41:18 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>, "Jon Smirl" <jonsmirl@gmail.com>,
	"Liam Girdwood" <liam.girdwood@wolfsonmicro.com>,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <20080110034919.GI17816@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
	<20080106004637.GJ4326@localhost.localdomain>
	<47824AA3.5070808@freescale.com>
	<20080107182853.GA17312@sirena.org.uk>
	<20080110034919.GI17816@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Mon, Jan 07, 2008 at 06:28:54PM +0000, Mark Brown wrote:
> > On Mon, Jan 07, 2008 at 09:52:03AM -0600, Timur Tabi wrote:
> > > David Gibson wrote:
> >
> > > > Ok, but couldn't you strucutre your I2S or fabric driver so that it
> > > > only becomes fully operational once the codec driver has registered
> > > > with it?
> >
> > > Not in ASoC V1.  You have to understand, ASoC V1 was designed without any
> > > consideration for runtime-bindings and other OF goodies.  All connections
> > > between the drivers are static, literally.  In fact, I wouldn't be surprised if
> > > some ASoC drivers cannot be compiled as modules.
> >
> > I'd just like to emphasise this point - ASoC v1 really doesn't
> > understand the idea that the components of the sound subsystem might be
> > probed separately.  It's set up to handle bare hardware with everything
> > being probed from code in the machine/fabric driver.  This makes life
> > very messy for platforms with something like the device tree.
> >
> > As has been said, handling this properly is one of the major motivations
> > behind ASoC v2.
>
> Ick.  Ok.
>
> Nonetheless, messing up the device tree to workaround ASoC V1's silly
> limitations is not a good idea.  The device tree must represent the
> hardware as much as possible.  If that means we have to have a bunch
> of platform-specific hacks to instatiate the drivers in the correct
> order / combination, that's unfortunate, but there you go.

ASOC v2 is sitting on a Wolfson server out of tree. I have been using
it for several months without problem. The pace of it being merged
could probably be sped up.

>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>


-- 
Jon Smirl
jonsmirl@gmail.com
