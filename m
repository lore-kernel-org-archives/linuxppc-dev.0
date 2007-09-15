Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8C282DDE18
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 00:28:05 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8FDKEeJ008667
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 09:20:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8FES1rS409462
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 08:28:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8FES1oX027557
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 08:28:01 -0600
Subject: Re: [patch 1/4] cuimage for Bamboo board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070915021952.GD25414@localhost.localdomain>
References: <20070914185410.387074000@linux.vnet.ibm.com> >
	<20070914185648.698807000@linux.vnet.ibm.com>
	<20070915021952.GD25414@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 15 Sep 2007 09:26:50 -0500
Message-Id: <1189866410.17593.4.camel@localhost.localdomain>
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

On Sat, 2007-09-15 at 12:19 +1000, David Gibson wrote:
> On Fri, Sep 14, 2007 at 01:54:11PM -0500, Josh Boyer wrote:
> > Add a cuboot wrapper for the Bamboo board.  This also removes some obsoleted
> > linker declarations that have been moved into ops.h
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Heh, well, I know I acked this already, but...

:)

> 
> [snip]
> > --- /dev/null
> > +++ linux-2.6/arch/powerpc/boot/cuboot-bamboo.c
> > @@ -0,0 +1,30 @@
> > +/*
> > + * Old U-boot compatibility for Ebony
> 
> Error in the comment here.

Fixed.

> 
> [snip]
> > --- linux-2.6.orig/arch/powerpc/boot/bamboo.c
> > +++ linux-2.6/arch/powerpc/boot/bamboo.c
> > @@ -24,8 +24,7 @@
> >  #include "4xx.h"
> >  #include "44x.h"
> >  
> > -extern char _dtb_start[];
> > -extern char _dtb_end[];
> > +static u8 *bamboo_mac0, *bamboo_mac1;
> 
> This additional handling of the MAC addresses should really also be
> mentioned in the commit comment.

Quite right.  I'll revise the commit comment.

josh
