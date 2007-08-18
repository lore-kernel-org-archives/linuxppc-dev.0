Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F815DDE33
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2007 02:34:43 +1000 (EST)
In-Reply-To: <20070817181718.GA15792@ld0162-tx32.am.freescale.net>
References: <20070817181718.GA15792@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <55FCD650-548C-40C9-8B1E-16259EF93F1D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/7 v2] fs_enet: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
Date: Sat, 18 Aug 2007 11:36:24 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2007, at 1:17 PM, Scott Wood wrote:

> The existing OF glue code was crufty and broken.  Rather than fix  
> it, it
> will be removed, and the ethernet driver now talks to the device tree
> directly.
>
> The old, non-CONFIG_PPC_CPM_NEW_BINDING code can go away once CPM
> platforms are dropped from arch/ppc (which will hopefully be soon),  
> and
> existing arch/powerpc boards that I wasn't able to test on for this
> patchset get converted (which should be even sooner).
>
> mii-bitbang.c now also uses the generic bitbang code.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Sorry, the previous version of this patch had bb_ops in the wrong
> place, and wouldn't build when not using the new binding.

This patch seems to mix moving to using the device tree directly w/o  
some other modifications.  Can it be broken into those two changes as  
they'd be easier to review.

- k
