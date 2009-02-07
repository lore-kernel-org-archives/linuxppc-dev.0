Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6A33ADDDE0
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 19:22:19 +1100 (EST)
Date: Sat, 07 Feb 2009 00:22:14 -0800 (PST)
Message-Id: <20090207.002214.259050726.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Rework I$/D$ coherency (v2)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090202001035.E1390DDF3D@ozlabs.org>
References: <20090202001035.E1390DDF3D@ozlabs.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 02 Feb 2009 11:10:24 +1100

> +/* has to be a macro because of include dependencies */
> +static inline int is_exec_fault(void)
> +{
> +	return current->thread.regs && TRAP(current->thread.regs) == 0x400;
> +}

Nice macro :-)
