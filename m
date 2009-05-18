Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD09DDE005
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 03:20:20 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4IHKHnw023869
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 10:20:17 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4IHKGhX019942
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 12:20:16 -0500 (CDT)
Date: Mon, 18 May 2009 12:20:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: fs_enet build breakage
Message-ID: <20090518172016.GB18620@b07421-ec1.am.freescale.net>
References: <1242630064.18075.48.camel@pasglop>
	<9732983B-B67C-4831-BBAB-65472BE0F279@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9732983B-B67C-4831-BBAB-65472BE0F279@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 18, 2009 at 08:23:17AM -0500, Kumar Gala wrote:
> 
> On May 18, 2009, at 2:01 AM, Benjamin Herrenschmidt wrote:
> 
> >Hi Kumar
> >
> >Commit 4484079d517c2b6521621be0b1ea246ccc55c7d7 from your next branch
> >breaks my 8xx test config with the following error:
> >
> >/home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c: In  
> >function ‘setup_immap’:
> >/home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c: 
> >947: error: ‘IMAP_ADDR’ undeclared (first use in this function)
> >/home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c: 
> >947: error: (Each undeclared identifier is reported only once
> >/home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c: 
> >947: error: for each function it appears in.)
> >
> >I'm still pushing it with a bunch of other stuff to "test" so people  
> >get
> >to find more breakage but it will need to be fixed for the actual  
> >"next"
> >branch.
> >
> >Cheers,
> >Ben.
> >
> 
> I'm pretty sure the driver changes to address this are in dave's net- 
> next tree.

Won't this break git bisect?

Not to mention anyone trying to use your tree now...

-Scott
