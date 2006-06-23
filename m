Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBADE67B2A
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 01:31:17 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1Ftncn-0008Kb-PT
	for linuxppc-dev@ozlabs.org; Fri, 23 Jun 2006 10:31:14 -0500
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Subject: Re: 8641 open nits 
In-Reply-To: Your message of "Fri, 23 Jun 2006 10:11:39 CDT."
	<6C66805F-22DD-4EC2-B852-101BF1E84612@kernel.crashing.org>
References: <E1Frjet-0004PA-J1@jdl.com>
	<D9D3C577-D46A-47BA-A1E0-844B95061F57@kernel.crashing.org>
	<6C66805F-22DD-4EC2-B852-101BF1E84612@kernel.crashing.org>
Date: Fri, 23 Jun 2006 10:31:13 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ftncn-0008Kb-PT@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> Jon,
> 
> Any update on the following nits:
> * duplication of entry in cputable

Earlier, we discussed it internally, and there are a few
issues differentiating the cores, so the sentiment was to
leave it as is for now.

> * include of <platforms/86xx/mpc8641_hpcn.h> in asm-powerpc/mpc86xx.h

That has to stay unless the IRQ patch is applied first.
Ben said "No" to that one so far.  The include stays for now.

> * mpc86xx_exclude_device cleanup and movement to pci.c
> * fixing up mpc86xx_hpcn_probe()

Those are all going to be cleaned up pending Ben's IRQ rewrite.

Thanks,
jdl
