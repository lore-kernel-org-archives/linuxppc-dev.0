Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 857D867A2E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 08:36:17 +1100 (EST)
Date: Mon, 27 Feb 2006 22:36:12 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: copying /sys causes fans to spin up
Message-ID: <20060227213612.GB21832@suse.de>
References: <20060227160911.GA17569@suse.de>
	<1141075795.4809.15.camel@localhost.localdomain>
	<20060227213435.GA21832@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060227213435.GA21832@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Feb 27, Olaf Hering wrote:

>  On Tue, Feb 28, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2006-02-27 at 17:09 +0100, Olaf Hering wrote:
> > > Ben, 
> > > 
> > > 
> > > some tool copies /sys, and while doing it, the fans start to spin up on
> > > my G5. Any idea how to fix it, other than not reading from /sys? Have to
> > > find the exact file.
> > 
> > Interesting... it's causing the i2c bus to go nuts... It would be useful
> > to find out what file indeed...
> 
> For Olof it was /sys/devices/platform/windfarm.0/hd-temp, but I cant
> test it right now.

my dmesg has:

windfarm: failed to attach ds1775 hd-temp to i2c
windfarm: failed to attach MAX6690 sensor


Maybe thats harmless, but I have seen it on a few different G5.
