Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 08D92DDE9B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 22:37:51 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l84CbmjR015240
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 08:37:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l84Cbh3w424088
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 06:37:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l84CbhQq013906
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 06:37:43 -0600
Date: Tue, 4 Sep 2007 07:37:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [patch 5/6] Walnut board support
Message-ID: <20070904073741.1adab0ba@weaponx.rchland.ibm.com>
In-Reply-To: <1188741546.3772.5.camel@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.514442000@linux.vnet.ibm.com>
	<20070903011112.GE31499@localhost.localdomain>
	<1188741546.3772.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 02 Sep 2007 08:59:06 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Mon, 2007-09-03 at 11:11 +1000, David Gibson wrote:
> > On Fri, Aug 31, 2007 at 03:04:54PM -0500, Josh Boyer wrote:
> > > Board support for the PPC405 Walnut evaluation board
> > > 
> > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > 
> > [snip]
> > > --- linux-2.6.orig/arch/powerpc/platforms/40x/Kconfig
> > > +++ linux-2.6/arch/powerpc/platforms/40x/Kconfig
> > > @@ -53,13 +53,13 @@
> > >  #	help
> > >  #	  This option enables support for the IBM PPC405GPr evaluation board.
> > >  
> > > -#config WALNUT
> > > -#	bool "Walnut"
> > > -#	depends on 40x
> > > -#	default y
> > > -#	select 405GP
> > > -#	help
> > > -#	  This option enables support for the IBM PPC405GP evaluation board.
> > > +config WALNUT
> > > +	bool "Walnut"
> > > +	depends on 40x
> > > +	default y
> > > +	select 405GP
> > > +	help
> > > +	  This option enables support for the IBM PPC405GP evaluation board.
> > 
> > Surely this needs WANT_DEVICE_TREE, too.
> 
> Yes, will be fixed.

Er, actually no it won't.  It doesn't need to be selected here, as 40x
in arch/powerpc/platforms/Kconfig.cputype already selects
WANT_DEVICE_TREE.  Same thing that ebony and bamboo do for 44x.

josh
