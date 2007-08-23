Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF30DDDFA3
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 12:53:23 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7N2tJ4k6144080
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 12:55:20 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7N2us2g183792
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 12:56:54 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7N2rKCu008436
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 12:53:20 +1000
Date: Thu, 23 Aug 2007 12:49:37 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Message-ID: <20070823024937.GD7042@localhost.localdomain>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<20070822143047.6c8a0d4e@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070822143047.6c8a0d4e@weaponx.rchland.ibm.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 02:30:47PM -0500, Josh Boyer wrote:
> On Wed, 22 Aug 2007 10:19:21 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> > Guys,
> > 
> > I was wondering if I could get your help with looking at the  
> > following lists and determining if we have an issue or not related  
> > the following files:
> > 
> > Getting some classification on these would be good.  Possibly  
> > classifications, doesn't build in ARCH=powerpc, remove include, real  
> > issue, etc.
> 
> Sure.
> 
> > ./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ocp.h>
> > ./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ibm4xx.h>
> 
> These one depends on IBM_OCP in Kconfig.  We don't select/enable that on
> any existing arch/powerpc 4xx stuff so it won't be built anyway.

Nor will we ever enable IBM_OCP in arch/powerpc: the device tree
entirely obsoletes the OCP crap.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
