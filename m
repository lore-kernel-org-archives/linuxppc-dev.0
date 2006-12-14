Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1946E67BED
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 16:39:11 +1100 (EST)
Subject: Re: [PATCH 2/15] powerpc, celleb: Basic supports for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200612140138.kBE1cb1O000668@toshiba.co.jp>
References: <200612140138.kBE1cb1O000668@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 16:37:35 +1100
Message-Id: <1166074655.11914.313.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Woodhouse <dwmw2@infradead.org>, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I'm not sure if it's a good idea to claim CHRP compatibility
> > here. Is that a workaround for a specific incompatibility? Normally,
> > I'd say you should print "machine\t\t: BEAT %s\n" or
> > "machine\t\t: Celleb %s\n", since you are definitely not running
> > a CHRP compatible firmware.
> 
> This is placed only to "trick" Anaconda into installing Fedora Core Linux.
> Fedora refuses to be installed into 'unknown' system.

David, can you do some serious LART'ing of whoever is responsible for
this in anaconda ? Is there at least an option somebody can pass on the
commmand line to make it work on unknown platforms ?

It's not the first time stupid userland assumptions are causing us
problems and it won't be the last, but I'd be really annoyed to have to
let that one through...

Ben.
