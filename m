Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp7.wanadoo.fr (smtp7.wanadoo.fr [193.252.22.24])
	by ozlabs.org (Postfix) with ESMTP id 426CF2BF07
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 01:38:38 +1100 (EST)
Date: Mon, 3 Jan 2005 15:45:57 +0100
To: Philippe Guyot <pguyot@cvf.fr>
Message-ID: <20050103144557.GD9197@pegasos>
References: <20050101150055.GA15400@pegasos>
	<855e88d0050103060766b09bd0@mail.gmail.com>
	<20050103143015.GB9197@pegasos> <200501031530.54487.pguyot@cvf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200501031530.54487.pguyot@cvf.fr>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	mikemartin@linux.ca, debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 03, 2005 at 03:30:54PM +0100, Philippe Guyot wrote:
> On Monday 03 January 2005 15:30, Sven Luther wrote:
> > On Mon, Jan 03, 2005 at 09:07:31AM -0500, Mike Martin wrote:
> > > On Mon, 3 Jan 2005 15:01:02 +0100, Sven Luther <sven.luther@wanadoo.fr>
> > > wrote:
> > >
> > > [snip]
> > >
> > > > What exact machine do you have again ?
> > >
> > > An IBM 7043. It's a 43p-140 labeled as a 604e 332 Mhz.
> 
> 
> I suppose you meen 233 Mhz ?
> >
> > Well, prep_pci.c does know about :
> >
> >   IBM RS/6000 7043-240 (ibm_doral)
> >   IBM RS/6000 7024-E30
> >
> > As far as IBM boxes are concerned. Doe the -140 have stuff in common with
> > leigh's -240 (the -140 being mono-cpu while the -240 being dual ?).
> 
> More different than that, 140 is more recent.
> 
> But works fine with Debian woody.(sorry Sven...)

Yeah, that is not the problem, the problem is that it doesn't work with the
2.6.8 kernel used by debian/sarge. So, now, the first order of business to fix
this is to find out what exactly is broken in the 2.6.8 kernel on this
hardware, fish out patches which may or may not solve the issue, and get it
solved. I will soon be making a kernel-source-2.6.8 upload for the powerstack
II problem i have hardware for, so it would be nice to fix these issues at the
same time. 

Once we have a working kernel, we will upload partman-prep from Cajus
Pollmeier, and add a prep-installer, and there will be propper prep support in
sarge, at least for the powerstack II.

> > Ok, understandable, still, getting it to netboot would be a first step to
> > getting it working right later.
> >
> > > If I can get it to boot the system (even from floppy or cd) I will
> > > have it to help test stuff. Otherwise it goes back under the desk
> > > where it came from.
> 
> If there is such a deadline, why not consider to install first a woody (many 
> successes exist) then upgrading to sarge after ?

That is always a solution. Getting the 2.6 debian kernel fixed would be nice
though. 

Friendly,

Sven Luther
