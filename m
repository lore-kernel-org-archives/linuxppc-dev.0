Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8897DDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 12:48:05 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m482m1Bd014629
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 22:48:01 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m482m1Ss258354
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 22:48:01 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m482m0E0027106
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 22:48:00 -0400
Date: Wed, 7 May 2008 21:46:30 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for IBM coreconnect
	busses.
Message-ID: <20080507214630.2f13fd22@zod.rchland.ibm.com>
In-Reply-To: <20080508001850.GB5156@yookeroo.seuss>
References: <20080507204734.574B6185804E@mail138-sin.bigfish.com>
	<20080508001850.GB5156@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 May 2008 10:18:50 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, May 07, 2008 at 01:47:31PM -0700, Stephen Neuendorffer wrote:
> > The IBM coreconnect names are pretty well defined, it appears.  In
> > addition, the Xilinx versions of these IPs seem to be proliferating.
> > Hence, in the future let's prefer to use the standard names.  I've
> > left the old names in for some backward compatibility for existing
> > device trees.
> > 
> > Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> 
> If you're talking about future trees, can't you just slap "simple-bus"
> on them avoid this monster id table?

What is that and how does it work?

josh
