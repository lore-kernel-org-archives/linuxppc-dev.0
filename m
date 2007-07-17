Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B84A6DDEC8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:56:56 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Add StorCenter DTS first draft. 
In-Reply-To: Your message of "Tue, 17 Jul 2007 17:34:05 CDT."
	<469D43DD.8020102@freescale.com>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
	<E1IAvVm-0005yQ-LO@jdl.com> <469D43DD.8020102@freescale.com>
Date: Tue, 17 Jul 2007 17:56:51 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IAvyN-00065b-Ob@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Scott Wood mumbled:
> Jon Loeliger wrote:
> > How about "soc8241@80000000" instead?
> 
> How about just "soc@80000000"?  Those model numbers in the names are a 
> PITA to find from limited functionality environments such as the 
> bootwrapper, require things like stdout-path to be different on every 
> soc, and don't comply with the generic names recommendation.

Oh!  Right.  No problem.

jdl
