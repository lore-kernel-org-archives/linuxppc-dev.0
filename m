Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp9.wanadoo.fr (smtp9.wanadoo.fr [193.252.22.22])
	by ozlabs.org (Postfix) with ESMTP id B3A202BF16
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2005 18:48:24 +1100 (EST)
Date: Fri, 7 Jan 2005 08:57:28 +0100
To: mikemartin@linux.ca
Message-ID: <20050107075727.GC18660@pegasos>
References: <855e88d005010405417d49dcfb@mail.gmail.com>
	<200501041523.j04FNoO0009594@arbas.nms.ulrich-teichert.org>
	<855e88d005010407396309a9f9@mail.gmail.com>
	<855e88d005010420367a92617a@mail.gmail.com>
	<855e88d00501051935117a64ea@mail.gmail.com>
	<855e88d005010621103e081bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <855e88d005010621103e081bb@mail.gmail.com>
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

On Fri, Jan 07, 2005 at 12:10:49AM -0500, Mike Martin wrote:
> Another update, More success
> 
> > An update (Sucess!!!):
> > After jogging some people's memory I found out that this machine has a
> > PCI token ring card (which I wasn't using) because the on-board
> > ethernet went flaky. This certainly helps explain my intermitent
> > network, and quite possibly the short up-times before crashing. As we
> > guessed - a hardware problem.
> > 
> > Is there any way (jumper ?) to disable the onboard ethernet? I may try
> > not loading the modules for it and see if the machine becomes stable.
> > Would a standard PCI ethernet card work as a substitute (likely won't
> > netboot)?
> 
> I checked the machine's docs - there appears to be no jumper to
> disable the onboard ethernet. However, If I simply unplug the ethernet
> cable the instability seems to diappear. The machine just did a
> flawless install booting from Leigh's disk, Woody root on a floppy and
> base on cd-rom.

What about d-i or a debian kernel ? I will make a new upload of the powerpc
kernel this weekend, and if there is a fix needed for 43P-140, i would like to
fix it before that.

> I have a PCI ethernet card left over from an old PentiumPro. It says
> it is a 3Com "Fast EtherLink XL PCI" "3C905-TX". Would this card work
> in this machine? Would it be able to netboot (doubtfull).

Not sure if you need a forth-rom enabled card or not. I plugged a cheap
realtek card in the powerstack, but it didn't even appear in lspci, but that
was before the pci irq remapping, so ...

Friendly,

Sven Luther
