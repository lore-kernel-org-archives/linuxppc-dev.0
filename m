Return-Path: <sydneymartin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 20B0B2BF16
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2005 16:10:51 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so518720wra
	for <linuxppc-dev@ozlabs.org>; Thu, 06 Jan 2005 21:10:49 -0800 (PST)
Message-ID: <855e88d005010621103e081bb@mail.gmail.com>
Date: Fri, 7 Jan 2005 00:10:49 -0500
From: Mike Martin <sydneymartin@gmail.com>
To: Ulrich Teichert <krypton@ulrich-teichert.org>
In-Reply-To: <855e88d00501051935117a64ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <855e88d005010405417d49dcfb@mail.gmail.com>
	<200501041523.j04FNoO0009594@arbas.nms.ulrich-teichert.org>
	<855e88d005010407396309a9f9@mail.gmail.com>
	<855e88d005010420367a92617a@mail.gmail.com>
	<855e88d00501051935117a64ea@mail.gmail.com>
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

Another update, More success

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

I checked the machine's docs - there appears to be no jumper to
disable the onboard ethernet. However, If I simply unplug the ethernet
cable the instability seems to diappear. The machine just did a
flawless install booting from Leigh's disk, Woody root on a floppy and
base on cd-rom.

I have a PCI ethernet card left over from an old PentiumPro. It says
it is a 3Com "Fast EtherLink XL PCI" "3C905-TX". Would this card work
in this machine? Would it be able to netboot (doubtfull).

MikeMartin
