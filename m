Return-Path: <davidlohr@hp.com>
Received: from g9t1613g.houston.hp.com (g9t1613g.houston.hp.com [15.240.0.71])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F37751A0872
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 07:37:45 +1000 (EST)
Received: from g2t2352.austin.hp.com (g2t2352.austin.hp.com [15.217.128.51])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 5A53862507
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 21:30:26 +0000 (UTC)
Message-ID: <1407360614.3395.2.camel@buesod1.americas.hpqcorp.net>
Subject: Re: [3.13.y.z extended stable] Patch "locking/mutex: Disable
 optimistic spinning on some architectures" has been added to staging queue
From: Davidlohr Bueso <davidlohr@hp.com>
To: Andev <debiandev@gmail.com>
Date: Wed, 06 Aug 2014 14:30:14 -0700
In-Reply-To: <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
References: <1407358496-23094-1-git-send-email-kamal@canonical.com>
 <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@lists.ubuntu.com,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
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

On Wed, 2014-08-06 at 17:25 -0400, Andev wrote:
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

Well 3.13.y.z isn't an Ubuntu kernel, its upstream, and those archs
*are* supported.
