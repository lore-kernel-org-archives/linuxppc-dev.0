Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 80E64DE1BC
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 08:30:24 +1100 (EST)
Date: Wed, 19 Mar 2008 14:30:37 -0700 (PDT)
Message-Id: <20080319.143037.180042261.davem@davemloft.net>
To: roland@redhat.com
Subject: Re: [PATCH 5/8] sparc64 ptrace: forced_successful_syscall_return()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080319212001.2DB8526F995@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319212001.2DB8526F995@magilla.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	tglx@linutronix.de, sparclinux@vger.kernel.org, paulus@samba.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	mingo@elte.hu, rth@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roland McGrath <roland@redhat.com>
Date: Wed, 19 Mar 2008 14:20:01 -0700 (PDT)

> Define the forced_successful_syscall_return() macro to
> pair with our force_successful_syscall_return() definition.
> 
> Signed-off-by: Roland McGrath <roland@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
