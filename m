Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24B78DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:32:42 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1LCY3vs8732776
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:34:03 -0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1L0a6Il119150
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:36:06 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1L0WaOm016538
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:32:36 +1100
Date: Wed, 21 Feb 2007 11:26:07 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/14] Re-organize Kconfig code for 4xx in arch/powerpc
Message-ID: <20070221002607.GF10231@localhost.localdomain>
References: <20070220021236.3609EDDD0A@ozlabs.org>
	<1171979489.24204.62.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171979489.24204.62.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 07:51:29AM -0600, Josh Boyer wrote:
> On Tue, 2007-02-20 at 13:12 +1100, David Gibson wrote:
> > 
> > -# It's often necessary to know the specific 4xx processor type.
> > -# Fortunately, it is impled (so far) from the board type, so we
> > -# don't need to ask more redundant questions.
> > +# 40x specific CPU modules, selected based on the board above.
> >  config NP405H
> >  	bool
> > -	depends on ASH
> > +	#depends on ASH
> >  	default y
> 
> This always turns this option on, even for Ebony builds.  Should
> probably comment out the 'default y' for now as well.

Oops, yes.  Fixed.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
