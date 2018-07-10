Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Q6Jv5DJtzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 01:57:03 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id p1-v6so15165741wrs.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 08:57:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 10 Jul 2018 17:56:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>,
 stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id.au>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog/softlockup: Fix SOFTLOCKUP_DETECTOR=n build
Message-ID: <20180710155657.GA13019@gmail.com>
References: <1531129883.6480.7.camel@abdul.in.ibm.com>
 <20180709114716.GN2476@hirez.programming.kicks-ass.net>
 <1531159814.6480.11.camel@abdul.in.ibm.com>
 <20180710114210.GI2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180710114210.GI2476@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 09, 2018 at 11:40:14PM +0530, Abdul Haleem wrote:
> 
> > Thanks Peter for the patch, build and boot is fine.
> > 
> > Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> 
> Excellent, Ingo can you stick this in?

Sure, done!

Thanks,

	Ingo
