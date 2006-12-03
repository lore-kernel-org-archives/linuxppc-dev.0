Return-Path: <sven.luther@wanadoo.fr>
Received: from LAubervilliers-151-12-84-108.w193-252.abo.wanadoo.fr.
	(LNeuilly-152-23-83-57.w217-128.abo.wanadoo.fr [217.128.214.57])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5A9A67B77
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 02:02:20 +1100 (EST)
Date: Sun, 3 Dec 2006 15:57:50 +0100
From: Sven Luther <sven@genesi-usa.com>
To: Nicolas DET <nicolas@det-net.org>
Subject: Re: [PATCH 1/2] Fixed compiled issue tu to new of_platform.h header
Message-ID: <20061203145750.GA20359@powerlinux.fr>
References: <Pine.LNX.4.44L0.0611241557080.16422-100000@netrider.rowland.org>
	<1164403145.5653.93.camel@localhost.localdomain>
	<20061203082303.GA9129@powerlinux.fr>
	<20061203101343.6ceda991.nicolas@det-net.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061203101343.6ceda991.nicolas@det-net.org>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
	sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 03, 2006 at 10:13:41AM +0100, Nicolas DET wrote:
> On Sun, 3 Dec 2006 09:23:03 +0100
> S0ven Luther <sven@genesi-usa.com> wrote:
> 
> 
> > > Not that I know. But we could have a cleaner approach. The #include one
> > > dates a bit... we could have for example an ohci-core.ko with the core
> > > bits, and ochi-pci.ko, ohci-patform.ko etc... be separate modules linked
> > > on the first and instanciating it.
> > > 
> > > I'll have a look and will come up with either solution.
> > 
> 
> In my mind, this is the correct approch.
> 
> > Hi, ...
> > 
> > I am just wondering if i got dropped from the CCs or if there was no further
> > discussion on this.
> > 
> > The 2.6.19 kernel doesn't build when the efika patches are applied and the
> > ohci modules are built. We need a solution for this. Even disabling the patch
> > for ohci fails to build the ohci driver, but this could be a bad manipulation.
> > 
> 
> "Efika OHCI patches" does not exist. There is a new OHCI glue for OpenFrimware.

Whatever.

> > Is there any hint on the right way to go for this ? 
> > 
> 
> I'm currently running on 2.6.19 (the whole USB in kernel not kmod). It compiles and works fine.

Ok, the day you are able to run the same ohci driver binary on both pegasos
with ohci usb card, and efika, then we can speak.

Friendly,

Sven Luther
