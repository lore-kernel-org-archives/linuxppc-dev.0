Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0F41DDEDD9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 23:55:16 +1000 (EST)
Date: Thu, 26 Jun 2008 17:55:23 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 2/2] fs_enet: MDIO on GPIO support
Message-ID: <20080626175523.54728d07@vitb.ru.mvista.com>
In-Reply-To: <200806261321.24338.laurentp@cse-semaphore.com>
References: <200805261152.37636.laurentp@cse-semaphore.com>
	<48592322.3090201@pobox.com>
	<200806181716.40362.laurentp@cse-semaphore.com>
	<200806261321.24338.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Jun 2008 13:21:23 +0200
Laurent Pinchart <laurentp@cse-semaphore.com> wrote:

> > There should be no dependencies. When the OF GPIO support is not selected 
> > linux/of_gpio.h will define of_get_gpio() as a stub, so the fs_enet driver 
> > will fall back to the legacy binding.  
> 
> Have we reached a consensus on which tree the patch should go to ?
I think it should go through powerpc tree, not seeing too much netdev-generic stuff in here.
If noone will object, Kumar will pick it up I guess...

-- 
Sincerely, 
Vitaly
