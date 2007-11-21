Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D297DDECB
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:51:14 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALIo8CM009688
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 13:50:08 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALJpARs122046
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 12:51:10 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALJpAS2021125
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 12:51:10 -0700
Date: Wed, 21 Nov 2007 13:51:09 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 5/14] powerpc: Fix 440/440A machine check handling
Message-ID: <20071121135109.73b9e98f@weaponx>
In-Reply-To: <1195674530.6970.86.camel@pasglop>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061714.0AB82DEAF1@ozlabs.org>
	<20071121071240.141d2917@weaponx>
	<1195674530.6970.86.camel@pasglop>
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

On Thu, 22 Nov 2007 06:48:50 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Why didn't you just add a ppc_md.machine_check_exception to the
> > effected boards?  Then you could have gotten rid of the ifdefs all
> > together.
> 
> Hrm... it's per processor, not per board. I didn't feel like digging
> which board uses which processor and go fixup all the ppc_md's

Sounds like something a generic function could probe for from the DTS.
I'll look at doing something here when I start making 44x multiplatform
(soon).

josh
