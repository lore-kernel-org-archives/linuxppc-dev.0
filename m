Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9FF9C67C8F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jul 2005 06:27:21 +1000 (EST)
Date: Tue, 5 Jul 2005 22:27:17 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050705202717.GA26014@suse.de>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<20050703172955.GA25976@suse.de>
	<20050703183237.GC16764@smtp.west.cox.net>
	<20050705181448.GA28142@suse.de>
	<20050705194724.GB6878@smtp.west.cox.net>
	<20050705195441.GA15455@suse.de>
	<20050705195819.GD6878@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050705195819.GD6878@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Jul 05, Tom Rini wrote:

> On Tue, Jul 05, 2005 at 09:54:41PM +0200, Olaf Hering wrote:
> >  On Tue, Jul 05, Tom Rini wrote:
> > 
> > > gcc info page says that -mcpu=powerpc won't work for 601.
> > 
> > -mcpu=common may work for everyone, after a quick grep in
> > gcc/config/rs6000
> 
> It does, and that's the code bloat you're trying to get rid of :)

3397494  579544  519704 4496742  449d66 ../O-ppc-cpucommon/vmlinux
3469857  579544  519704 4569105  45b811 ../O-ppc-default/vmlinux

-mcpu=powerpc reduces text size still more than -mcpu=750
