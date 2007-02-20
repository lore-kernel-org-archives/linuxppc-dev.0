Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 059E2DDDCF
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 04:57:44 +1100 (EST)
To: Stuart Yoder <b08248@freescale.com>
Subject: Re: [DTC PATCH] remove check for interrupt-controller property under
	/chosen
In-Reply-To: Your message of "Mon, 19 Feb 2007 11:28:27 CST."
	<200702191728.l1JHSRfo025427@ld0164-tx32.am.freescale.net>
References: <200702191728.l1JHSRfo025427@ld0164-tx32.am.freescale.net> 
Date: Tue, 20 Feb 2007 11:57:37 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HJZFB-0004Tg-5b@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Stuart Yoder mumbled:
> 
> Remove warning for missing interrupt-controller property
> under /chosen.  There is consensus that this
> property does not belong here.
> 
> Also, add a warning if interrupt-controller _is_ found
> under /chosen.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>

Applied.

Thanks,
jdl
