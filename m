Return-Path: <olof@lixom.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D7C09B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 06:10:47 +1000 (EST)
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 83106DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 06:10:47 +1000 (EST)
Date: Wed, 22 Jul 2009 15:18:07 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Best hardware platform for native compiling...
Message-ID: <20090722201807.GA11949@lixom.net>
References: <200907211116.52963.david.jander@protonic.nl>
	<20090721095251.GG32034@lisas.de>
	<200907211231.37299.david.jander@protonic.nl>
	<20090721120007.GA23164@iram.es> <1248180459.31121.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248180459.31121.9.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, David Jander <david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 21, 2009 at 10:47:39PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2009-07-21 at 14:00 +0200, Gabriel Paubert wrote:
> > Well, I got one recently here in Spain. Shipping charges are fairly 
> > large (it's not exactly a light and compact machine). But the current 
> > dollar exchange rate helps ;-)
> > 
> > Now I have not yet found the way to install Debian on it
> > (it refuses to boot Debian's CDROM), but I have not had
> > time to investigate either.
> 
> It uses SLOF which should be capable of decent netbooting, so it should
> be possible to either netboot yaboot and have it load the kernel and
> initramfs, or maybe make a zImage with both included and netboot that.

Placing the debian (netinst) installer ramdisk and kernel on the /boot
partition and booting it from there should work too (after adding it to
the yaboot config).


-Olof
