Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6714E2BF1A
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jan 2005 02:01:15 +1100 (EST)
From: Sebastian Heutling <sheutlin@gmx.de>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20041231095557.GA16480@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<41CF77A9.9040405@gmx.net>  <20041231095557.GA16480@pegasos>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 16:00:49 +0100
Message-Id: <1104505249.6794.5.camel@weizen.left.earth>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
Reply-To: sheutlin@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-12-31 at 10:55 +0100, Sven Luther wrote:
> On Mon, Dec 27, 2004 at 03:47:05AM +0100, Christian wrote:
> > Marc Dietrich schrieb:
> > >Hi all,
> > >
> > >I read this thread about booting a PowerStack with newer kernels. 
> > >Motivated by this, I tried to compile a 2.6.10 kernel on my machine (with 
> > >sym53c825a onboard). Sadly, the scsi controller always timeouts during 
> > >initialisation. I 
> 
> I also have some strange issues with network support using the standard debian
> 2.6.8 kernel. ifconfig upping the decchip ethernet on the powerstack freezes
> the kernel, and i hear reports of problems on IBM PReP hardware too with not
> working ethernet, altough there is no freeze.
> 
> Any idea on this ? 

Does it contain the IRQ patch? Where does it boot from SCSI or net? What
PCI-Devices are installed?
I use an older patched 2.6.8 debian kernel. It works fine here except
that I can't insert the eepro100 module via /etc/modules on boot because
some times it crashes on module insertion (or on ifconfig via init
script - I don't remember exactly) and sometimes not. Therefore I do it
by hand after boot up.


Sebastian Heutling
