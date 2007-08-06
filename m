Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A87FDDDF5
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 22:18:15 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76CIBe4024745
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:18:11 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l76CIBxC555246
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:18:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l76CIBM8025347
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:18:11 -0400
Date: Mon, 6 Aug 2007 07:31:44 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, dwg@au1.ibm.com
Subject: Re: [patch 02/10] 4xx Kconfig cleanup
Message-ID: <20070806123144.GY3925@crusty.rchland.ibm.com>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
	<20070803161710.335369000@linux.vnet.ibm.com>
	<20070804074538.GA5662@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070804074538.GA5662@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 04, 2007 at 05:45:38PM +1000, David Gibson wrote:
> On Fri, Aug 03, 2007 at 11:09:02AM -0500, Josh Boyer wrote:
> > Remove some leftover cruft in the 40x Kconfig file.  Also make sure we
> > select WANT_DEVICE_TREE for 40x.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > 
> > ---
> >  arch/powerpc/platforms/40x/Kconfig     |   77 ---------------------------------
> >  arch/powerpc/platforms/Kconfig.cputype |    1 
> >  2 files changed, 1 insertion(+), 77 deletions(-)
> > 
> > --- linux-2.6.orig/arch/powerpc/platforms/40x/Kconfig
> > +++ linux-2.6/arch/powerpc/platforms/40x/Kconfig
> > @@ -1,16 +1,3 @@
> > -config 4xx
> > -	bool
> > -	depends on 40x || 44x
> > -	default y
> 
> You've removed this one, but I don't see you re-add it anywhere.  We
> still need to define the CONFIG_4xx symbol or things will break..

I don't need to re-add it.  It's already in

arch/powerpc/platforms/Kconfig.cputype

josh
