Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CED44DDF9C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 23:05:34 +1000 (EST)
Message-Id: <3DC08C70-5096-47BF-8452-367495F8B19E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1213750053.678227.22239172650.qpush@coopers>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 0/9] powerpc: Add kernel support for POWER7 VSX. 
Date: Wed, 18 Jun 2008 08:05:23 -0500
References: <1213750053.678227.22239172650.qpush@coopers>
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

> The following set of patches adds Vector Scalar Extentions (VSX)
> support for POWER7.  Includes context switch, ptrace and signals  
> support.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> This series is on top of the POWER7 cputable entry patch.
>
> Paulus: please consider for your 2.6.27 tree.

I bit better explanation of what VSX would be useful.  Its not clear  
to me exactly how these instructions behave such that we have to touch  
all this code.

- k
