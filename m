Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF4ECDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 17:46:34 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/1] [PPC] 8xx swap bug-fix
Date: Tue, 5 Feb 2008 09:46:21 +0300
References: <20080201181003.a3daf6ed.kim.phillips@freescale.com>
	<47A45269.7080403@scram.de>
	<20080204182421.GA3930@loki.buserror.net>
In-Reply-To: <20080204182421.GA3930@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802050946.21292.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hi Scott,

 You are right. The TLB handlers for 8xx in arch/powerpc branch set the 
PAGE_ACCESSED flag unconditionally too. And the 
include/asm-powerpc/pgtable-ppc32.h file still includes the comment that this 
is the bug. So, probably the corresponding patch for powerpc branch will be 
usefull. Does anybody use swap with some of the 8xx-based boards supported in 
powerpc branch ?

 Regards, Yuri

On Monday 04 February 2008 21:24, Scott Wood wrote:
> On Sat, Feb 02, 2008 at 12:22:17PM +0100, Jochen Friedrich wrote:
> > Hi Yuri,
> > 
> > >  Here is the patch which makes Linux-2.6 swap routines operate correctly 
on
> > > the ppc-8xx-based machines.
> > 
> > is there any 8xx board left which isn't ported to ARCH=powerpc?
> 
> More importantly, is this something that is also broken in arch/powerpc?  It
> looks like it has the same code...
> 
> -Scott
> 

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
