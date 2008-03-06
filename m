Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B60DFDE1DD
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 01:07:42 +1100 (EST)
Message-Id: <74F2472D-65F2-422B-821B-554EC81A3494@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Gerald Van Baren <gvb.linuxppc.dev@cgmail.com>
In-Reply-To: <20080306003316.GA14068@cideas.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] The MPC83xx family doesn't support performance monitor
	instructions
Date: Thu, 6 Mar 2008 08:07:38 -0600
References: <20080306003316.GA14068@cideas.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 5, 2008, at 6:33 PM, Gerald Van Baren wrote:

> "Errata to MPC8349EA PowerQUICC[tm] II Pro Integrated Host Processor  
> Family
> Reference Manual, Rev. 1" (Freescale)
>
> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
> ---
>
> Hi Kumar,
>
> Please apply this fix to 2.6.25rc4 if possible.  Without this
> patch, the PPC_83xx family configuration is broken (will not compile).

What's the compile issue?  Some of the 83xx family have perf mon so we  
need to fix the compile issue.

- k
