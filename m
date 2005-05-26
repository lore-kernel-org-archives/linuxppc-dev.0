Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A1D4679E2
	for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2005 12:50:59 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Parker <palfrey@tevp.net>
In-Reply-To: <429517FF.2030400@tevp.net>
References: <429237EC.4010104@tevp.net> <1116891693.30513.3.camel@gaston>
	<429517FF.2030400@tevp.net>
Content-Type: text/plain
Date: Thu, 26 May 2005 12:50:46 +1000
Message-Id: <1117075847.9076.9.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Reading DVDs on a Mac mini
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-26 at 02:27 +0200, Tom Parker wrote:
> Benjamin Herrenschmidt wrote:
> > On Mon, 2005-05-23 at 22:07 +0200, Tom Parker wrote:
> >>The version of libdvdread in use is 0.9.4 (the Debian 0.9.4-5 
> >>libdvdread3 package).
> 
> > Does the debian package of libdvdread contains the CSS stuff ?
> 
> No it doesn't, but it does include a shell script to download it if 
> you're living somewhere where libdvdcss is ok, and libdvdread will 
> dynamically load libdvdcss if it exists. I'm using libdvdcss 1.2.8 (latest).
> 
> > Have you tried booting OS X and playing the DVD once ? Maybe the drive
> > wants a zone to be set at least once, which MacOS does the first time
> > you play a DVD
> 
> Had to reinstall OS X to test this, and yup, it wants a zone to be set. 
> Returning back to Linux, some fiddling with regionset and some region 1 
> and 2 DVDs lets me come to the following conclusions:
> 
> 1) It's an RPC-2 DVD drive (i.e. evil, CSS-in-hardware drive), with the 
> whole "5 changes and then it locks" policy.
> 2) It appears to be a really evil variant of RPC-2, in that if you've 
> got a CSS-locked DVD in the drive, and you're set on a different region 
> to the disk, you can't even get at the encrypted contents. The 
> aforementioned read errors keep turning up, making libdvdcss useless. 
> Or, this may just be an ide-cd bug with this drive...
> 3) If drive region == disc region, it plays DVDs fine.
> 
>  >>hdparm -i says the drive is a "MATSHITACD-RW CW-8124".
> 
> If anyone happens to have an RPC-1 firmware for this drive, or fixes to 
> ide-cd, I'd be most grateful! Some googling for the former is currently 
> unhelpful.

Yah, I googled too and ended up with the same conclusion =P

Ben.
