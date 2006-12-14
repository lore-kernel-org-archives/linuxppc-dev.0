Return-Path: <SRS0+5a2c09d7947b623b42e4+1208+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD28867BF8
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 18:37:30 +1100 (EST)
Subject: Re: [PATCH 2/15] powerpc, celleb: Basic supports for Celleb
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1166074655.11914.313.camel@localhost.localdomain>
References: <200612140138.kBE1cb1O000668@toshiba.co.jp>
	<1166074655.11914.313.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 07:37:17 +0000
Message-Id: <1166081837.5253.822.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-12-14 at 16:37 +1100, Benjamin Herrenschmidt wrote:
> > > I'm not sure if it's a good idea to claim CHRP compatibility
> > > here. Is that a workaround for a specific incompatibility? Normally,
> > > I'd say you should print "machine\t\t: BEAT %s\n" or
> > > "machine\t\t: Celleb %s\n", since you are definitely not running
> > > a CHRP compatible firmware.
> > 
> > This is placed only to "trick" Anaconda into installing Fedora Core Linux.
> > Fedora refuses to be installed into 'unknown' system.
> 
> David, can you do some serious LART'ing of whoever is responsible for
> this in anaconda ? Is there at least an option somebody can pass on the
> commmand line to make it work on unknown platforms ?

Define 'work'. I believe it ends up doing _different_ things according
to the machine type -- in particular the selection of the bootloader
setup. You want to treat all unknown machines as CHRP? Paul, can we do
that?

When does the Fedora team get a Celleb machine for compatibility
testing, btw?

-- 
dwmw2
