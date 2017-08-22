Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcJXQ6wkszDqln
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 04:11:18 +1000 (AEST)
Date: Wed, 23 Aug 2017 04:11:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: Tree for Aug 22
Message-ID: <20170823041117.780097f7@canb.auug.org.au>
In-Reply-To: <20170822183816.7925e0f8@canb.auug.org.au>
References: <20170822183816.7925e0f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This tree fails to boot on my qemu test.  2 boot logs attached.

Paul, Nick, is this the same/similar to the other RCU/lockup bug you
are chasing.  This is the first time I have seen this failure.

This qemu boot is in full emulation mode if I add --enable-kvm to the
qemu command, it does not fail to boot.  (the test just boots and then shuts down)
-- 
Cheers,
Stephen Rothwell
