Return-Path: <jdl@jdl.com>
Received: from jdl.com (colo.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F411467B6C
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 01:20:06 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] dtc: add setting of physical boot cpu 
In-Reply-To: Your message of "Wed, 31 May 2006 08:31:51 +1000."
	<20060530223309.9AB7667B3E@ozlabs.org>
References: <20060518035734.2B2CA67A6D@ozlabs.org>
	<7AC7793A-74F3-4596-BF28-19BCA9E388CF@watson.ibm.com>
	<20060518170017.B15E367A6C@ozlabs.org>
	<20060530223309.9AB7667B3E@ozlabs.org>
Date: Wed, 07 Jun 2006 09:49:43 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FnzLr-0007Ot-NL@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Michael Neuling mumbled:
> dtc always sets the physical boot CPU to 0xfeedbeef.  Add a -b option to
> set this.    Also add warnings when using the wrong property with the
> wrong blob version.  
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied and pushed out to:

     http://www.jdl.com/git_repos

Sorry for the hang time.

Thanks,
jdl
