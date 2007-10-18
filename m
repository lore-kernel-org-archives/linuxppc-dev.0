Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE822DDF4C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:32:47 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Thu, 18 Oct 2007 17:30:17 +0400
References: <200710181108.19413.yur@emcraft.com>
	<200710181718.00965.yur@emcraft.com>
	<20071018082514.2ce1f43b@weaponx.rchland.ibm.com>
In-Reply-To: <20071018082514.2ce1f43b@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710181730.17717.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 18 October 2007 17:25, Josh Boyer wrote:
> >  Understood. The situation here is that the boards, which required these
> > modifications, have no support in the arch/powerpc branch. So this is 
> > why we made this in arch/ppc.
> 
> Bit of a dilemma then.  What board exactly?

 These are the Katmai and Yucca PPC440SPe-based boards (from AMCC).

> > > Also, I'd rather see something along the lines of hugetlbfs support instead.
> > 
> >  Here I agree with Benjamin. Furthermore, IIRC the hugetlb file-system is
> > supported for PPC64 architectures only. Here we have PPC32.
> 
> Well that needs fixing anyway, but ok.  Also, is the modified binutils
> only required for userspace to take advantage here?  Seems so, but I'd
> just like to be sure.

 You are right, for userspace only. 

> 
> josh
> 

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
