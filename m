Return-Path: <mpatocka@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7ACBF1A0872
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 07:35:07 +1000 (EST)
Date: Wed, 6 Aug 2014 17:33:24 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Andev <debiandev@gmail.com>
Subject: Re: [3.13.y.z extended stable] Patch "locking/mutex: Disable
 optimistic
 spinning on some architectures" has been added to staging queue
In-Reply-To: <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1408061730590.10016@file01.intranet.prod.int.rdu2.redhat.com>
References: <1407358496-23094-1-git-send-email-kamal@canonical.com>
 <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Davidlohr Bueso <davidlohr@hp.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@lists.ubuntu.com,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@tilera.com>,
 John David Anglin <dave.anglin@bell.net>, linux-arm-kernel@lists.infradead.org,
 Jason Low <jason.low2@hp.com>, Waiman Long <waiman.long@hp.com>,
 Vineet Gupta <vgupta@synopsys.com>, Kamal Mostafa <kamal@canonical.com>,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wed, 6 Aug 2014, Andev wrote:

> On Wed, Aug 6, 2014 at 4:54 PM, Kamal Mostafa <kamal@canonical.com> wrote:
> > This is a note to let you know that I have just added a patch titled
> >
> >     locking/mutex: Disable optimistic spinning on some architectures
> >
> > to the linux-3.13.y-queue branch of the 3.13.y.z extended stable tree
> > which can be found at:
> >
> >  http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue
> >
> > This patch is scheduled to be released in version 3.13.11.6.
> >
> 
> This patch is specifically for parisc, sparc32, tile32, metag-lock1,
> arc-!llsc and hexagon none of which Ubuntu supports.
> 
> Why are you backporting this patch?
> 
> --
> Andev

I guess - it's less time consuming to backport all patches for stable than 
to ponder on each patch if it applies to Ubuntu or not...

Mikulas
