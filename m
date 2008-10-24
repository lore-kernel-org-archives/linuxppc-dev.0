Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59EE8DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 18:52:30 +1100 (EST)
Subject: Re: [PATCH] Allocate resources for PHB DLPAR add
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <49014A41.6040700@austin.ibm.com>
References: <49014A41.6040700@austin.ibm.com>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 18:51:35 +1100
Message-Id: <1224834695.7654.435.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-23 at 23:08 -0500, Nathan Fontenot wrote:
> Resources for PHB's that are DLPAR added to a system are not acquired.
> Not having these resources allocated causes an oops during DLPAR
> remove of the PHB when we try to release non-existant resources.
> 
> The patch appears a bit messy, this is mainly due to moving everything
> one tab to the left in the pcibios_allocate_bus_resources routine.  The
> big functionality change in this routine is only that the 
> list_for_each_entry() loop is pulled out and moved to the necessary
> calling routine.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
>  
> ---

Patch looks good.

I'll include it in the next batch hopefully along with a variant of
another patch I'm working on to fix other issues I found with our PCI
hotplug resource management. 

Cheers,
Ben.
