Return-Path: <frankvm@frankvm.com>
Received: from janus.localdomain (frankvm.xs4all.nl [80.126.170.174])
	by ozlabs.org (Postfix) with ESMTP id D21CA67B69
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 04:36:29 +1000 (EST)
Date: Wed, 29 Jun 2005 20:36:28 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Andreas Schwab <schwab@suse.de>
Message-ID: <20050629183628.GA23185@janus>
References: <20050629145013.GA21494@janus> <jehdfhnnr7.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <jehdfhnnr7.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: include/asm-ppc/atomic.h: fluff in inline assembly code?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2005 at 06:14:52PM +0200, Andreas Schwab wrote:
> Frank van Maarseveen <frankvm@frankvm.com> writes:
> 
> > What is the point of all those v->counter arguments?
> 
> It tells the compiler that v->counter is changed by the asm.

So it's an optimized alternative for "memory" in the clobber list?
ok, I couldn't find that anywhere in the doc.

But v->counter is not supposed to be accessed directly by the
compiler (i.e. by C code) at all, is it? so it shouldn't matter.

Even if it would be: the counter itself is declared "volatile int"
which basically tells the compiler not to cache it in a register.

-- 
Frank
