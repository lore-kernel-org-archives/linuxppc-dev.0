Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp3.wanadoo.fr (smtp3.wanadoo.fr [193.252.22.28])
	by ozlabs.org (Postfix) with ESMTP id 99B6D2BDB5
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jan 2005 09:20:57 +1100 (EST)
Date: Fri, 31 Dec 2004 23:28:08 +0100
To: Sebastian Heutling <sheutlin@gmx.de>
Message-ID: <20041231222808.GB8078@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<41CF77A9.9040405@gmx.net> <20041231095557.GA16480@pegasos>
	<1104505249.6794.5.camel@weizen.left.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1104505249.6794.5.camel@weizen.left.earth>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org,
	Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 31, 2004 at 04:00:49PM +0100, Sebastian Heutling wrote:
> On Fri, 2004-12-31 at 10:55 +0100, Sven Luther wrote:
> > On Mon, Dec 27, 2004 at 03:47:05AM +0100, Christian wrote:
> > > Marc Dietrich schrieb:
> > > >Hi all,
> > > >
> > > >I read this thread about booting a PowerStack with newer kernels. 
> > > >Motivated by this, I tried to compile a 2.6.10 kernel on my machine (with 
> > > >sym53c825a onboard). Sadly, the scsi controller always timeouts during 
> > > >initialisation. I 
> > 
> > I also have some strange issues with network support using the standard debian
> > 2.6.8 kernel. ifconfig upping the decchip ethernet on the powerstack freezes
> > the kernel, and i hear reports of problems on IBM PReP hardware too with not
> > working ethernet, altough there is no freeze.
> > 
> > Any idea on this ? 
> 
> Does it contain the IRQ patch? Where does it boot from SCSI or net? What
> PCI-Devices are installed?

Probably not, just the standard debian kernel, i donÃ't remember any irq
patches, but there where a bunch of patches from leighbb. it is done
netbooting, and the only pci device installed is the cirruss logic graphic
card.

> I use an older patched 2.6.8 debian kernel. It works fine here except
> that I can't insert the eepro100 module via /etc/modules on boot because
> some times it crashes on module insertion (or on ifconfig via init
> script - I don't remember exactly) and sometimes not. Therefore I do it
> by hand after boot up.

Can you mail me the patch in question, or better yet mail it to the bug report
about this ? 287933@bugs.debian.org

Friendly,

Sven Luther
