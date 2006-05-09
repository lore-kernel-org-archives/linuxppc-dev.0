Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B095A679F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 09:00:26 +1000 (EST)
Date: Tue, 9 May 2006 16:00:20 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
Subject: Re: Viable PPC platform?
Message-ID: <20060509230020.GA11885@gate.ebshome.net>
References: <91B22F93A880FA48879475E134D6F0BE028A43D2@CA1EXCLV02.adcorp.kla-tencor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE028A43D2@CA1EXCLV02.adcorp.kla-tencor.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, May 09, 2006 at 03:52:20PM -0700, Howard, Marc wrote:
> > 
> > In message <20060509171520.GA10886@gate.ebshome.net> you wrote:
> > >
> > > After many years of doing embedded Linux stuff I still don't 
> > > understand why people are so fond of initrd.
> > > 
> > > For temporary stuff - tempfs is much better and flexible. For r/o 
> > > stuff - just make separate MTD partition (cramfs, squashfs) 
> > and mount 
> > > it directly as root. Both options will waste significantly less 
> > > memory.
> > 
> > Agreed.
> > 
> > And if somebody wants to see facts and numbers, please see
> > http://www.denx.de/wiki/view/DULG/RootFileSystemSelection
> > 
> 
> One size does not fit all.  We have an application with a very large
> file system.  It can't fit in the available flash, however we do have a
> ton of RAM (512MB).  NFS is not an option nor is it desirable (latency
> and availability issues).  Boot time is not an issue either in this case
> as it takes the equipment many minutes to calibrate and initialize.
> 
> initrd also solves another problem.  The combined uBoot multi-image
> although huge (>32 MB) represents a complete system firmware snapshot in
> a single (huge) file.  By selecting the appropriate uImage the host can
> guarantee the linux build, device drivers, application version and FPGA
> firmware revs (the embedded board is rebooted to guarantee a repeatable
> starting state).  This makes revision control for the overall system
> much easier, especially since the host system is running windoze.

This all is nice provided you use network for boot. IMHO this is quite 
_rare_ setup (especially Windows host!!!). For 99% of embedded designs 
this is obviously not a viable option.

-- 
Eugene
