Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mNPD00mRzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 19:34:07 +1000 (AEST)
Message-ID: <17a90b003bcc2f1dda2b92b65f16c212ffddc571.camel@linux.intel.com>
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, rashmica <rashmicy@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 09 Aug 2018 12:34:01 +0300
In-Reply-To: <87ftzo9i77.fsf@concordia.ellerman.id.au>
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
 <87mutxb9qy.fsf@concordia.ellerman.id.au>
 <7857c69a-a209-541b-b2e1-9fe2e288ca65@gmail.com>
 <87ftzo9i77.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-09 at 16:18 +1000, Michael Ellerman wrote:
> rashmica <rashmicy@gmail.com> writes:
> > On 08/08/18 17:25, Michael Ellerman wrote:
> > > Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > > > 
> > mpe I sent a patch doing that awhile ago and you obviously didn't
> > like
> > it because you never merged it :P

Hmm... I (as an author of the test case) never saw that patch.

> Sorry, I wasn't sure who should merge it, and never followed up.

lib/* most of the time under Andrew's responsibility, though since it's
orphaned in MAINTAINERS, anyone can push, though, I think, it's good to
notify Andrew.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
