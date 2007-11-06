Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DE23DDD0D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 00:36:23 +1100 (EST)
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Replace some #includes of asm/of_platform.h with
	linux/of_platform.h.
In-Reply-To: Your message of "Tue, 06 Nov 2007 09:36:07 +1100."
	<20071106093607.329b29f6.sfr@canb.auug.org.au>
References: <1194296705.7158.45.camel@ld0161-tx32>
	<20071106093607.329b29f6.sfr@canb.auug.org.au>
Date: Tue, 06 Nov 2007 07:36:11 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IpObD-0001M3-US@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Stephen Rothwell mumbled:
> 
> Hi Jon,
> 
> Thanks for starting this.

No problem.

> >  #include <asm/of_device.h>
> 
> asm/of_device.h -> linux/of_device.h as well?  :-)


Oh!  Sure!  I'll respin these two.

jdl
