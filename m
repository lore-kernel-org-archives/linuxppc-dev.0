Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 45C431A399D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jan 2016 06:43:57 +1100 (AEDT)
Date: Thu, 31 Dec 2015 14:43:47 -0500 (EST)
Message-Id: <20151231.144347.54643465516219979.davem@davemloft.net>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de,
 linux-arch@vger.kernel.org, andrew.cooper3@citrix.com,
 virtualization@lists.linux-foundation.org,
 stefano.stabellini@eu.citrix.com, tglx@linutronix.de, mingo@elte.hu,
 hpa@zytor.com, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 mingo@kernel.org, ralf@linux-mips.org, andreyknvl@google.com
Subject: Re: [PATCH v2 07/32] sparc: reuse asm-generic/barrier.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <1451572003-2440-8-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-8-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 31 Dec 2015 21:06:38 +0200

> On sparc 64 bit dma_rmb, dma_wmb, smp_store_mb, smp_mb, smp_rmb,
> smp_wmb, read_barrier_depends and smp_read_barrier_depends match the
> asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
> 
> nop uses __asm__ __volatile but is otherwise identical to
> the generic version, drop that as well.
> 
> This is in preparation to refactoring this code area.
> 
> Note: nop() was in processor.h and not in barrier.h as on other
> architectures. Nothing seems to depend on it being there though.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
