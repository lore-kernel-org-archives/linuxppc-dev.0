Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 9A14CDF965
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:05:03 +1000 (EST)
Date: Thu, 21 Aug 2008 14:05:02 -0700 (PDT)
Message-Id: <20080821.140502.146697690.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] math-emu: Add support for reporting exact invalid
	exception
From: David Miller <davem@davemloft.net>
In-Reply-To: <1219323021-7273-2-git-send-email-galak@kernel.crashing.org>
References: <1219323021-7273-1-git-send-email-galak@kernel.crashing.org>
	<1219323021-7273-2-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 21 Aug 2008 07:50:21 -0500

> Some architectures (like powerpc) provide status information on the exact
> type of invalid exception.  This is pretty straight forward as we already
> report invalid exceptions via FP_SET_EXCEPTION.
> 
> We add new flags (FP_EX_INVALID_*) the architecture code can define if it
> wants the exact invalid exception reported.
> 
> We had to split out the INF/INF and 0/0 cases for divide to allow reporting
> the two invalid forms properly.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: David S. Miller <davem@davemloft.net>
