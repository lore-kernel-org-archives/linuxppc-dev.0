Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A867FDDDEC
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 18:10:20 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: Use RCU based pte free mechanism for all
	powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1227135004-27607-1-git-send-email-galak@kernel.crashing.org>
References: <1227135004-27607-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 18:10:10 +1100
Message-Id: <1227165010.7185.205.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-19 at 16:50 -0600, Kumar Gala wrote:
> Refactor the RCU based pte free code that was used on ppc64 to be used
> on all powerpc.
> 
> Additionally refactor pte_free() & pte_free_kernel() into common code
> between ppc32 & ppc64.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Only does RCU if CONFIG_SMP
> * Removed hash_page_sync() as its not needed if we do RCU

Patch looks good. I'll try to test it a bit tomorrow.

Cheers,
Ben.
