Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 72C45DDE9B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 05:44:46 +1000 (EST)
Date: Tue, 11 Sep 2007 14:45:41 -0500
From: Olof Johansson <olof@lixom.net>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575
	on FSL boards
Message-ID: <20070911194541.GB13105@lixom.net>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<20070911172000.GC10743@lixom.net>
	<9C9F1918-1B55-4426-8138-842B9AAA5BD5@kernel.crashing.org>
	<20070911182234.GA12802@lixom.net>
	<424B650B-C272-45FC-BBC6-F090A9474082@kernel.crashing.org>
	<24F46474-1425-4C8B-A400-4D18D28932F2@freescale.com>
	<6EF5E5F8-703B-4C49-B458-92CD0CDF89A0@kernel.crashing.org>
	<65BEA2C0-2494-490E-B0EE-B51C96B64075@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <65BEA2C0-2494-490E-B0EE-B51C96B64075@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 02:22:21PM -0500, Becky Bruce wrote:

> >>
> >> I'm also guilty of not noticing the original patch - my apologies.
> >
> > maybe we should just have a platforms/fsl for all boards from  
> > freescale.  Not having things broken up by which processor family  
> > they are for.
> 
> What do you envision as being under there?  Subdirs?  How's it  
> organized? In some ways that might make sense, but I think we'd need  
> to sit down and think it through with all the twisted combinations  
> our hardware people come up with.  The fact is that there's really no  
> clean way to deal with all the wackiness.  So we just pick something  
> that fits OK and go with it.

Given the amount of stuff under ??xx, it would be pretty easy to contain
already. All the drivers are under sysdev/ and all core support is under
kernel/. There's really very little under each platform directory at
the moment, just a few shared device tree parsers and some device fixups.


-Olof
