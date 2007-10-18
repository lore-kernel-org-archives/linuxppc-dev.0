Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 341FEDDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:41:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9IEfsHo008395
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 10:41:54 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9IEfqXA286120
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:41:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9IEfpqV023541
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:41:52 -0600
Date: Thu, 18 Oct 2007 09:41:49 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Message-ID: <20071018094149.59e179eb@weaponx.rchland.ibm.com>
In-Reply-To: <200710181730.17717.yur@emcraft.com>
References: <200710181108.19413.yur@emcraft.com>
	<200710181718.00965.yur@emcraft.com>
	<20071018082514.2ce1f43b@weaponx.rchland.ibm.com>
	<200710181730.17717.yur@emcraft.com>
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

On Thu, 18 Oct 2007 17:30:17 +0400
Yuri Tikhonov <yur@emcraft.com> wrote:

> On Thursday 18 October 2007 17:25, Josh Boyer wrote:
> > >  Understood. The situation here is that the boards, which required these
> > > modifications, have no support in the arch/powerpc branch. So this is 
> > > why we made this in arch/ppc.
> > 
> > Bit of a dilemma then.  What board exactly?
> 
>  These are the Katmai and Yucca PPC440SPe-based boards (from AMCC).

Hm...  We should get those in.  At this point in the kernel cycle, your
patch would be 2.6.25 material anyway so perhaps there is some time to
get Katmai and Yucca done by then.

> 
> > > > Also, I'd rather see something along the lines of hugetlbfs support instead.
> > > 
> > >  Here I agree with Benjamin. Furthermore, IIRC the hugetlb file-system is
> > > supported for PPC64 architectures only. Here we have PPC32.
> > 
> > Well that needs fixing anyway, but ok.  Also, is the modified binutils
> > only required for userspace to take advantage here?  Seems so, but I'd
> > just like to be sure.
> 
>  You are right, for userspace only. 

Ok.

josh
