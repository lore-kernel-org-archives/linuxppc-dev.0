Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C34F1DDFF2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 03:22:06 +1100 (EST)
Date: Thu, 11 Dec 2008 08:22:03 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Help enabling PCI endpoint on 460EX, host sees disabled
Message-ID: <20081211162203.GA8670@ovro.caltech.edu>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F8AD@tanisys-ex2.Tanisys.Local>
	<20081211001758.GA29190@ovro.caltech.edu>
	<1228993468.22413.165.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228993468.22413.165.camel@pasglop>
Cc: Ayman El-Khashab <AymanE@tanisys.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 10:04:28PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2008-12-10 at 16:17 -0800, Ira Snyder wrote:
> > On Wed, Dec 10, 2008 at 05:29:53PM -0600, Ayman El-Khashab wrote:
> > > My system consists of a pair of 460EXs attached by way of both PCI-E and
> > > PCI.  Ultimately my goal is to communicate between them via pci-e (is
> > > there anything out there that does this already?).
> > 
> > I can't help you with that exact board, but I've written an "ethernet
> > over PCI" driver for Linux and U-Boot. The Linux driver has been posted
> > here on linuxppc-dev and on the lkml. Search for "net: add PCINet
> > driver" and you'll find it.
> > 
> > It won't work on your board, but it should serve as a good example about
> > how to communicate over PCI.
> > 
> > You are the third user asking for something like this recently. :) Too
> > bad the mainline kernel developers seem to be mostly ignoring the
> > driver I wrote.
> 
> Don't get too disappointed... a lot of us are busy and things fall
> through the cracks.. it may just be that we had nothing bad to say about
> it :-)
> 
> Seriously, if you feel you didn't get useful reviews or that nothing is
> picking it up, just holler, and nag us. We all have pretty full plates
> and things do slip or just forgotten :-)
> 

Thanks Ben.

I'm still working on various issues with the hardware. Soon I'll be able
to easily test several boards in the same system at the same time. Once
I've proven that works, I'll start nagging :)

Is there a better subject line I should use to get attention, or should
I just start CC'ing people?

Sorry if I sounded negative in my post. It's just a little discouraging
when you don't get lots of feedback. I REALLY appreciate all of the work
you and everyone else is doing.

Ira
