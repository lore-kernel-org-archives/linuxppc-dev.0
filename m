Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcPXy3v3wzDrCd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 07:57:06 +1000 (AEST)
Date: Wed, 23 Aug 2017 07:57:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, ppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: Tree for Aug 22
Message-ID: <20170823075705.75432321@canb.auug.org.au>
In-Reply-To: <20170822193620.GA7752@linux.vnet.ibm.com>
References: <20170822183816.7925e0f8@canb.auug.org.au>
 <20170823041117.780097f7@canb.auug.org.au>
 <20170823041424.1dddeb2d@canb.auug.org.au>
 <20170822185923.GE11320@linux.vnet.ibm.com>
 <20170823051216.34f2c09f@canb.auug.org.au>
 <20170822193231.GF11320@linux.vnet.ibm.com>
 <20170822193620.GA7752@linux.vnet.ibm.com>
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

Hi Paul,

On Tue, 22 Aug 2017 12:36:20 -0700 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>
> To complete the thought, if you aren't already using it, I suggest
> applying Nick's patch:
> 
> http://lkml.kernel.org/r/20170822084348.21436-1-npiggin@gmail.com

OK, I applied that - with a little shoehorning due to commit

  71acb768f5b3 ("timers: Fix excessive granularity of new timers after a nohz idle")

from your cru tree.

my qemu test now boots and shuts down fine.

-- 
Cheers,
Stephen Rothwell
