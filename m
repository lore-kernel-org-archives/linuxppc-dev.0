Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 388D4DDF6E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 00:46:30 +1000 (EST)
Message-Id: <75D005F8-878F-4646-A9DE-7E1E7A57F537@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080623073807.E915670294@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/9] powerpc: Fix msr setting in 32 bit signal code
Date: Mon, 23 Jun 2008 09:46:15 -0500
References: <20080623073807.E915670294@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2008, at 2:38 AM, Michael Neuling wrote:

> If we set the SPE MSR bit in save_user_regs we can blow away the VEC
> bit.  This will never happen in reality (VMX and SPE will never be in
> the same processor as their opcodes overlap), but it looks bad.  Also
> when we add VSX here in a later patch, we can hit two of these at the
> same time.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---

I think it would also be good to comment about how this doesn't happen  
since they are the same MSR bit.  Having that comment might reduce  
confusion if anyone ever looks at this commit message in the future.   
(Plus you seem to have trailing white space in the commit message).

- k
