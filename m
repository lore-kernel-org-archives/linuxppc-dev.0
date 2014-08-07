Return-Path: <debiandev@gmail.com>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494481A0945
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 12:00:42 +1000 (EST)
Received: by mail-ie0-f182.google.com with SMTP id y20so3881812ier.27
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Aug 2014 19:00:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1407376502.12474.64.camel@fourier>
References: <1407358496-23094-1-git-send-email-kamal@canonical.com>
 <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
 <1407360614.3395.2.camel@buesod1.americas.hpqcorp.net>
 <1407376502.12474.64.camel@fourier>
Date: Wed, 6 Aug 2014 22:00:39 -0400
Message-ID: <CAJUuVQ4q8wN+iR84gkGgP-ax6pUY4oWFa83aH+LXwZFricgwXg@mail.gmail.com>
Subject: Re: [3.13.y.z extended stable] Patch "locking/mutex: Disable
 optimistic spinning on some architectures" has been added to staging queue
From: Andev <debiandev@gmail.com>
To: Kamal Mostafa <kamal@canonical.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Davidlohr Bueso <davidlohr@hp.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@lists.ubuntu.com,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
 John David Anglin <dave.anglin@bell.net>, linux-arm-kernel@lists.infradead.org,
 Jason Low <jason.low2@hp.com>, Waiman Long <waiman.long@hp.com>,
 Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2014 at 9:55 PM, Kamal Mostafa <kamal@canonical.com> wrote:
>
> On Wed, 2014-08-06 at 14:30 -0700, Davidlohr Bueso wrote:
>> Well 3.13.y.z isn't an Ubuntu kernel, its upstream, and those archs
>> *are* supported.
>
> Davidlohr's answer is correct: This is not an "Ubuntu kernel".
>
> 3.13.y.z is an "extended stable" kernel which follows the same rules as
> the kernel.org official stable kernels.  It contains no Ubuntu-specific
> patches, and supports the same arch's as mainline.
>
> More details about this and the other Canonical-funded-and-hosted
> "extended stable" kernel versions is available here:
>
>> For more information about the 3.13.y.z tree, see
>> https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

OK, thank you for clarification. I was unsure as this is not hosted on
kernel.org, I thought it was a Ubuntu specific kernel.

So we have the following stable kernels as of now:

3.10, 3.12, 3.13, 3.14, 3.15(for a few days), 3.16!

Interesting.
-- 
Andev
