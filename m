Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBh0NySzDvyC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:12 +1100 (AEDT)
In-Reply-To: <5720837D.6050807@linux.vnet.ibm.com>
To: xinhui <xinhui@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: peterz@infradead.org, boqun.feng@gmail.com, paulus@samba.org,
 tglx@linutronix.de, paulmck@linux.vnet.ibm.com
Subject: Re: [V4] powerpc: Implement {cmp}xchg for u8 and u16
Message-Id: <3tPxBg4LhYz9t80@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-27 at 09:16:45 UTC, xinhui wrote:
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
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d0563a1297e234ed37f6b51c2e9321

cheers
