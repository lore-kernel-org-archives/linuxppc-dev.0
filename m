Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwTkK27QZzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 17:59:21 +1000 (AEST)
Date: Thu, 28 Apr 2016 09:59:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V4] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160428075913.GT3430@twins.programming.kicks-ass.net>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <5720837D.6050807@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5720837D.6050807@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 27, 2016 at 05:16:45PM +0800, Pan Xinhui wrote:
> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> Implement xchg{u8,u16}{local,relaxed}, and
> cmpxchg{u8,u16}{,local,acquire,relaxed}.
> 
> It works on all ppc.
> 
> remove volatile of first parameter in __cmpxchg_local and __cmpxchg
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

Generally has the right shape; and I trust others to double check the
ppc-asm minutia.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
