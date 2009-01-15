Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8F25A47582
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 17:47:26 +1100 (EST)
Date: Wed, 14 Jan 2009 22:47:26 -0800 (PST)
Message-Id: <20090114.224726.240718844.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/2] powerpc: Allow debugging of LMBs with lmb=debug
From: David Miller <davem@davemloft.net>
In-Reply-To: <aab322f087db2ecc390ea5e224db143cf77d3067.1232001859.git.michael@ellerman.id.au>
References: <aab322f087db2ecc390ea5e224db143cf77d3067.1232001859.git.michael@ellerman.id.au>
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

From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 15 Jan 2009 17:46:01 +1100 (EST)

> The lmb debugging can be turned on at boottime with lmb=debug on the
> command line. However on powerpc that doesn't work, because we don't
> necessarily call lmb_dump_all().
> 
> So always call lmb_dump_all() after lmb_analyze(), no output is
> generated unless lmb=debug is found on the command line.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: David S. Miller <davem@davemloft.net>
