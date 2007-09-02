Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C77A3DDF4F
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 23:38:26 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l83Ddl0M020594
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 09:39:47 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l83DcNr6647554
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 09:38:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l83DcMHs012062
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 09:38:23 -0400
Subject: Re: [patch 5/6] Walnut board support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070903011112.GE31499@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com> >
	<20070831200643.514442000@linux.vnet.ibm.com>
	<20070903011112.GE31499@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 02 Sep 2007 08:59:06 -0500
Message-Id: <1188741546.3772.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-09-03 at 11:11 +1000, David Gibson wrote:
> On Fri, Aug 31, 2007 at 03:04:54PM -0500, Josh Boyer wrote:
> > Board support for the PPC405 Walnut evaluation board
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> [snip]
> > --- linux-2.6.orig/arch/powerpc/platforms/40x/Kconfig
> > +++ linux-2.6/arch/powerpc/platforms/40x/Kconfig
> > @@ -53,13 +53,13 @@
> >  #	help
> >  #	  This option enables support for the IBM PPC405GPr evaluation board.
> >  
> > -#config WALNUT
> > -#	bool "Walnut"
> > -#	depends on 40x
> > -#	default y
> > -#	select 405GP
> > -#	help
> > -#	  This option enables support for the IBM PPC405GP evaluation board.
> > +config WALNUT
> > +	bool "Walnut"
> > +	depends on 40x
> > +	default y
> > +	select 405GP
> > +	help
> > +	  This option enables support for the IBM PPC405GP evaluation board.
> 
> Surely this needs WANT_DEVICE_TREE, too.

Yes, will be fixed.

josh
