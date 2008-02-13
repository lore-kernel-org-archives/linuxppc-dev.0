Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 50142DDEE7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 09:24:01 +1100 (EST)
Date: Wed, 13 Feb 2008 14:24:32 -0800 (PST)
Message-Id: <20080213.142432.206908646.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [GIT]: Make LMB code sharable with sparc64.
From: David Miller <davem@davemloft.net>
In-Reply-To: <D846801F-AA6B-4238-9FA4-A712EABFE800@kernel.crashing.org>
References: <20080213.004120.22092044.davem@davemloft.net>
	<D846801F-AA6B-4238-9FA4-A712EABFE800@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 13 Feb 2008 07:12:26 -0600

> Does sparc have the concept of a phys_addr_t?  We are in the process  
> of expanding the lmb support to deal with 36-bit physical addresses on  
> 32-bit machines.

On sparc64, where I intend to use this, unsigned long's are 64-bit.
If you use some phys_addr_t type instead to help ppc32 along, that
would be perfectly fine with me.
