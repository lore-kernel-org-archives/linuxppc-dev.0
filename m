Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4CE6DDFD4
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 13:51:44 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l773sHYl3981522
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 13:54:17 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l773t5ld111734
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 13:55:05 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l773pWeZ021356
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 13:51:32 +1000
Date: Tue, 7 Aug 2007 13:06:35 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 02/10] 4xx Kconfig cleanup
Message-ID: <20070807030635.GD15619@localhost.localdomain>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
	<20070803161710.335369000@linux.vnet.ibm.com>
	<20070804074538.GA5662@localhost.localdomain>
	<20070806123144.GY3925@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070806123144.GY3925@crusty.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 07:31:44AM -0500, Josh Boyer wrote:
> On Sat, Aug 04, 2007 at 05:45:38PM +1000, David Gibson wrote:
> > On Fri, Aug 03, 2007 at 11:09:02AM -0500, Josh Boyer wrote:
> > > Remove some leftover cruft in the 40x Kconfig file.  Also make sure we
> > > select WANT_DEVICE_TREE for 40x.
> > > 
> > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > 
> > > ---
> > >  arch/powerpc/platforms/40x/Kconfig     |   77 ---------------------------------
> > >  arch/powerpc/platforms/Kconfig.cputype |    1 
> > >  2 files changed, 1 insertion(+), 77 deletions(-)
> > > 
> > > --- linux-2.6.orig/arch/powerpc/platforms/40x/Kconfig
> > > +++ linux-2.6/arch/powerpc/platforms/40x/Kconfig
> > > @@ -1,16 +1,3 @@
> > > -config 4xx
> > > -	bool
> > > -	depends on 40x || 44x
> > > -	default y
> > 
> > You've removed this one, but I don't see you re-add it anywhere.  We
> > still need to define the CONFIG_4xx symbol or things will break..
> 
> I don't need to re-add it.  It's already in
> 
> arch/powerpc/platforms/Kconfig.cputype

Ah, so it is.  Sorry.  In that case:

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
