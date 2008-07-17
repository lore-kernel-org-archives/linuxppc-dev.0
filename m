Return-Path: <jonsmirl@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 48D03DE2E1
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 22:05:51 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3383343pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 05:05:50 -0700 (PDT)
Message-ID: <9e4733910807170505k5aaf1c6fp10c6c268cb8e15c7@mail.gmail.com>
Date: Thu, 17 Jul 2008 08:05:49 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA
In-Reply-To: <8d6898730807170426wac4719cv7cd925cfcd91aa68@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
	<8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
	<1216203206.9723.0.camel@dinesh.dua>
	<1216274611.18207.6.camel@dinesh.dua>
	<20080717105614.GC15333@sirena.org.uk>
	<8d6898730807170426wac4719cv7cd925cfcd91aa68@mail.gmail.com>
Cc: dinesh <dinesh.dua@coraltele.com>, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/17/08, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Hi Dinesh,
>
> If that is your requirement then go and see the actual code
> sound/arm/aaci.c. They are not using DMA. It is programmed IO.


Search around the list archives, the first version of the
Efika/mpc5200 ac97 driver was programmed IO. The next version updated
it to DMA.


>
>
> Thanks
> Nobin Mathew
>
>
> On 7/17/08, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Jul 17, 2008 at 11:33:31AM +0530, dinesh wrote:
> >
> > > What i want is that i have a buffer in driver code which is also handled
> > > by some other application i want that this buffer data is to be used for
> > > capture and playback  stream fills data to another buffer which i can
> > > passover to my other application.
> >
> > Depending on what exactly you're doing here you may find that this is
> > best implemented in user space with an ALSA plugin rather than doing it
> > as part of a driver.  If you do want to do this in kernel space then the
> > parts of an ASoC driver which transfer audio data are just the same as
> > those for any other ALSA driver so things like sound/arm/aaci.c may
> > provide useful examples.
> >
>
>
> _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
