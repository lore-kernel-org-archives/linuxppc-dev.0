Return-Path: <sydneymartin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.207])
	by ozlabs.org (Postfix) with ESMTP id 0BA782BF0E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 14:35:52 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so389272wra
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Jan 2005 19:35:51 -0800 (PST)
Message-ID: <855e88d00501051935117a64ea@mail.gmail.com>
Date: Wed, 5 Jan 2005 22:35:50 -0500
From: Mike Martin <sydneymartin@gmail.com>
To: Ulrich Teichert <krypton@ulrich-teichert.org>
In-Reply-To: <855e88d005010420367a92617a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <855e88d005010405417d49dcfb@mail.gmail.com>
	<200501041523.j04FNoO0009594@arbas.nms.ulrich-teichert.org>
	<855e88d005010407396309a9f9@mail.gmail.com>
	<855e88d005010420367a92617a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	Philippe Guyot <pguyot@cvf.fr>
Subject: Re: 43p-140 install issues
Reply-To: mikemartin@linux.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > > I am begining to believe that there is some sort of hardware problem with your
> > > box or it is an upgraded version which was a -140 in it's previous life, but my
> > > -140 is rock solid with Leigh's 2.4.19 kernel - once it's up, that is.
> > > I will leave it running tonight to see what happens,

[snip]

> The machine was working fine under AIX when it was decomissioned. It
> had some issues with a disk going bad due to heat (blocked vents). But
> once they were cleared there were no issues. I am going to try the
> other machine. I'll keep my finger's crossed.
> 
> MikeMartin

An update (Sucess!!!):
After jogging some people's memory I found out that this machine has a
PCI token ring card (which I wasn't using) because the on-board
ethernet went flaky. This certainly helps explain my intermitent
network, and quite possibly the short up-times before crashing. As we
guessed - a hardware problem.

Is there any way (jumper ?) to disable the onboard ethernet? I may try
not loading the modules for it and see if the machine becomes stable.
Would a standard PCI ethernet card work as a substitute (likely won't
netboot)?

Now the success:
I put Leigh's boot floppy and the Woody root floppy (from
debian.yorku.ca mirror) into the second machine at noon today. By 1pm
I had a fully installed, configured and self-booting installation of
Woody on a 43p-140.

By 1:30 I had it re-pinned to "testing" and "dist-upgrad"ing. It was
finished and running great when I left work.

Since the machine is at work, I don't have much time to mess with it,
(since that's not my job!) but I will try in the next week to test
Sven's d-i disks on a second hard disk. It's the least I can do for
the help you've all given.

Thanks!
MikeMartin
