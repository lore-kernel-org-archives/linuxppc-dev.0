Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB8E8DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 00:53:24 +1000 (EST)
Message-Id: <DB1B686B-FE98-486B-B345-D18408C51135@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080618004733.BD2C870292@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/9] powerpc: Fix msr setting in 32 bit signal code
Date: Wed, 18 Jun 2008 09:53:07 -0500
References: <20080618004733.BD2C870292@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 7:47 PM, Michael Neuling wrote:

> If we set the SPE MSR bit in save_user_regs we can blow away the VEC
> bit.  This will never happen in reality, but it looks bad.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>
> arch/powerpc/kernel/signal_32.c |   10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

probably worth commenting on why this will never happen.

- k
