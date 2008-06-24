Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C43F1DE340
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 02:03:14 +1000 (EST)
Message-Id: <24347F5F-4F87-4921-AC78-8EFF92D2483E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080624105749.BE8B370294@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/9] powerpc: Fix msr setting in 32 bit signal code
Date: Tue, 24 Jun 2008 08:47:06 -0500
References: <20080624105749.BE8B370294@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2008, at 5:57 AM, Michael Neuling wrote:

> If we set the SPE MSR bit in save_user_regs we can blow away the VEC
> bit.  This doesn't matter in reality as they are infact the same bit
> but looks bad.
>
> Also, when we add VSX in a later patch, we need to be able to set two
> separate MSR bits here.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
