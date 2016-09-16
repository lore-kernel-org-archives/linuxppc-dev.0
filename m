Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbCF95cGKzDsZy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 21:08:12 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id n24so3517172pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 04:08:12 -0700 (PDT)
Date: Fri, 16 Sep 2016 21:08:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/13] powerpc: "paca->soft_enabled" based local atomic
 operation implementation
Message-ID: <20160916210803.167c3486@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:31:50 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Local atomic operations are fast and highly reentrant per CPU counters.
> Used for percpu variable updates. Local atomic operations only guarantee
> variable modification atomicity wrt the CPU which owns the data and
> these needs to be executed in a preemption safe way.

Great patches, I hope the review helped. Other than my minor comments,
I think the patches look good, so it's a good time for other reviewers
to take a look. Would be good to get an ack from Ben, Anton, or Paul too
at some point.

These will clash spectacularly with my exception vector rework
unfortunately, but that's how it goes. I can help with rebasing if
mine ends up going in first.

Thanks,
Nick
