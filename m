Return-Path: <felipe@cvf.fr>
Received: from mh2.cvf.fr (unknown [213.56.76.234])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B97A2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 01:31:12 +1100 (EST)
From: Philippe Guyot <pguyot@cvf.fr>
To: Sven Luther <sven.luther@wanadoo.fr>, mikemartin@linux.ca
Date: Mon, 3 Jan 2005 15:30:54 +0100
References: <20050101150055.GA15400@pegasos>
	<855e88d0050103060766b09bd0@mail.gmail.com>
	<20050103143015.GB9197@pegasos>
In-Reply-To: <20050103143015.GB9197@pegasos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501031530.54487.pguyot@cvf.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
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

On Monday 03 January 2005 15:30, Sven Luther wrote:
> On Mon, Jan 03, 2005 at 09:07:31AM -0500, Mike Martin wrote:
> > On Mon, 3 Jan 2005 15:01:02 +0100, Sven Luther <sven.luther@wanadoo.fr>
> > wrote:
> >
> > [snip]
> >
> > > What exact machine do you have again ?
> >
> > An IBM 7043. It's a 43p-140 labeled as a 604e 332 Mhz.


I suppose you meen 233 Mhz ?
>
> Well, prep_pci.c does know about :
>
>   IBM RS/6000 7043-240 (ibm_doral)
>   IBM RS/6000 7024-E30
>
> As far as IBM boxes are concerned. Doe the -140 have stuff in common with
> leigh's -240 (the -140 being mono-cpu while the -240 being dual ?).

More different than that, 140 is more recent.

But works fine with Debian woody.(sorry Sven...)


>
> > [snip]
> >
> > > set <minor> <flag> <on|off>
> > >
> > > minor is the partition, starting at 1, flag is the flag, (prep in this
> > > case) and on|off is obvious.
> > >
> > > It simply sets the prep flag, which is then translated as a 0x41
> > > partition type. I think this is a deficiency in the parted/libparted
> > > API, but well, there is not much we can do about that unless a major
> > > libparted change.
> >
> > Cool. That's good to know.
>
> It was added recently though.
>
> > > Yep, d-i uses devfs, still partitions start at 1.
> >
> > Ok. Oops
> >
> > > > I see how much more time I can buy with this machine. It may need to
> > > > go back into storage this week if I can't make it run. Not fun.
> > >
> > > What about donating it to debian or something such ?
> >
> > I'd love to however it's not mine to donate. It's the companies (They
> > have 2 actually, I might try the other one since it has slightly
> > different hardware).
>
> Well, you could argue that donating one might make the other one usefull :)
>
> > The problem is: at work, I can't netboot. There is no server that will
> > respond and I can't set one up. I had the machine at home for the
> > holidays and thus can boot it from my LAN. If I can't get it to
> > self-boot before I have to take it back to the office - then I'm
> > stuck.
>
> Ok, understandable, still, getting it to netboot would be a first step to
> getting it working right later.
>
> > If I can get it to boot the system (even from floppy or cd) I will
> > have it to help test stuff. Otherwise it goes back under the desk
> > where it came from.

If there is such a deadline, why not consider to install first a woody (many 
successes exist) then upgrading to sarge after ?


>
> Understandable too. What is the deadline ? I built a d-i kernel with the
> powerstack2 - utah pci irq patch, and it now works fine here. Still some
> work is needed, but basically this means i can scratch the disk on the box,
> and do some real d-i development, bringing in the partman-prep patch, and
> maybe even building a prep-installer that does the needed stuff to make it
> self-boot.
>
> I think you have to give your box back by monday next week though, right ?
> this could be too short, but let's see if we can make something happen.
>
> Right now, there are two issues :
>
>   1) the kernel may have some irq problems, or some other patching may be
>   needed.
>
>   2) partman-prep is not included in d-i.
>
>   3) there is no automated prep-installer in d-i.
>
> Watch out on : http://people.debian.org/~luther/prep for uploads i make.
>
> Friendly,
>
> Sven Luther
