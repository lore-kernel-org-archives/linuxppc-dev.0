Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41B86DDF74
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 05:55:44 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3CJtf2J027615
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 15:55:41 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CJteDQ202160
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:55:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CJtduD001546
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:55:40 -0600
Subject: Re: [PATCH v2] powerpc: Fix PowerPC 750CL and 750GX CPU features
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3d8deaa26ab67ccd0aeb4b827dc175a8@kernel.crashing.org>
References: <1176402805.6379.84.camel@zod.rchland.ibm.com>
	<3d8deaa26ab67ccd0aeb4b827dc175a8@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 14:54:33 -0500
Message-Id: <1176407673.6379.95.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 21:28 +0200, Segher Boessenkool wrote:
> > PowerPC 750CL has high BATs.  The patch below adds a CPU_FTRS_750CL 
> > that
> > includes that.  Without it, the original firmware mappings in the high 
> > BATs
> > aren't cleared which continue to override the linux translations.
> >
> > It also adds CPU_FTR_COMMON to CPU_FTRS_750GX for completeness.
> 
> Looks good to me, thanks Josh.  It would be nice to define
> the 750XX features as plain 750 + a few options, but that's
> a separate cleanup.

Yep, I was thinking a cleanup along those lines would be good.  I'd like
to get this current patch merged first, and then I can do that cleanup.
Didn't want to fight with patch dependency ordering for now (which is
also why I rolled the small GX fix into this patch).

josh
