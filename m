Return-Path: <linus971@gmail.com>
Received: from mail-vc0-x22e.google.com (mail-vc0-x22e.google.com
 [IPv6:2607:f8b0:400c:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 607212C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 06:25:07 +1100 (EST)
Received: by mail-vc0-f174.google.com with SMTP id ld13so1505179vcb.19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 12:25:02 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1395342510.14694.43.camel@buesod1.americas.hpqcorp.net>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFwH2sJKCH6hUf8H-7nMPo8YwFCR6oP8McZ5VpMcGDrYSw@mail.gmail.com>
 <1395342510.14694.43.camel@buesod1.americas.hpqcorp.net>
Date: Thu, 20 Mar 2014 12:25:01 -0700
Message-ID: <CA+55aFw8wSe-DUtZ8=rjFJzXYmOSsZ0JzS-_jsZKrDai8LZMXw@mail.gmail.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Davidlohr Bueso <davidlohr@hp.com>
Content-Type: text/plain; charset=UTF-8
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 12:08 PM, Davidlohr Bueso <davidlohr@hp.com> wrote:
>
> Oh, it does. This atomics technique was tested at a customer's site and
> ready for upstream.

I'm not worried about the *original* patch. I'm worried about the
incremental one.

Your original patch never applied to my tree - I think it was based on
-mm or something. So I couldn't verify my "let's go back to the
explicit 'waiters'" incremental patch against reverting and
re-applying the original patch.

So I'd like you to re-verify that that incremental patch really is
solid, and does what your original one did.

               Linus
