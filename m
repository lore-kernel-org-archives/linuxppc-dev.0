Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp6.wanadoo.fr (unknown [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id 3576B2BF12
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 19:07:12 +1100 (EST)
Date: Thu, 6 Jan 2005 09:15:51 +0100
To: mikemartin@linux.ca
Message-ID: <20050106081550.GB18980@pegasos>
References: <855e88d005010405417d49dcfb@mail.gmail.com>
	<200501041523.j04FNoO0009594@arbas.nms.ulrich-teichert.org>
	<855e88d005010407396309a9f9@mail.gmail.com>
	<855e88d005010420367a92617a@mail.gmail.com>
	<855e88d00501051935117a64ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <855e88d00501051935117a64ea@mail.gmail.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>,
	Philippe Guyot <pguyot@cvf.fr>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2005 at 10:35:50PM -0500, Mike Martin wrote:
> > > > I am begining to believe that there is some sort of hardware problem with your
> > > > box or it is an upgraded version which was a -140 in it's previous life, but my
> > > > -140 is rock solid with Leigh's 2.4.19 kernel - once it's up, that is.
> > > > I will leave it running tonight to see what happens,
> 
> [snip]
> 
> > The machine was working fine under AIX when it was decomissioned. It
> > had some issues with a disk going bad due to heat (blocked vents). But
> > once they were cleared there were no issues. I am going to try the
> > other machine. I'll keep my finger's crossed.
> > 
> > MikeMartin
> 
> An update (Sucess!!!):
> After jogging some people's memory I found out that this machine has a
> PCI token ring card (which I wasn't using) because the on-board
> ethernet went flaky. This certainly helps explain my intermitent
> network, and quite possibly the short up-times before crashing. As we
> guessed - a hardware problem.
> 
> Is there any way (jumper ?) to disable the onboard ethernet? I may try
> not loading the modules for it and see if the machine becomes stable.
> Would a standard PCI ethernet card work as a substitute (likely won't
> netboot)?

You have to blacklist the module in discover/hotplug, and it won't be loaded
at install time. In d-i, i believe you could rmmod it as soon as possible, not
sure if you can blacklist it, i will investigate.

I want to know something else from you though. In the end, did the debian
2.6.8 kernel (and d-i) work for you or not, i sort of lost track of this.

> Now the success:
> I put Leigh's boot floppy and the Woody root floppy (from
> debian.yorku.ca mirror) into the second machine at noon today. By 1pm
> I had a fully installed, configured and self-booting installation of
> Woody on a 43p-140.
> 
> By 1:30 I had it re-pinned to "testing" and "dist-upgrad"ing. It was
> finished and running great when I left work.
> 
> Since the machine is at work, I don't have much time to mess with it,
> (since that's not my job!) but I will try in the next week to test
> Sven's d-i disks on a second hard disk. It's the least I can do for
> the help you've all given.

Hehe. Also, if we fix the issue, it will come in handy next time you want to
install it, not to count that you may like eventual security builds of the
debian kernel down the road.

Friendly,

Sven Luther
