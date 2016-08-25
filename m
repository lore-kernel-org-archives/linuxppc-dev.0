Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKb7H3dm1zDrcc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 17:15:55 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id hh10so2626942pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 00:15:55 -0700 (PDT)
Date: Thu, 25 Aug 2016 17:15:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 00/12] powerpc: "paca->soft_enabled" based local
 atomic operation implementation
Message-ID: <20160825171543.7b23ec01@roar.ozlabs.ibm.com>
In-Reply-To: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 25 Aug 2016 11:59:51 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Local atomic operations are fast and highly reentrant per CPU counters.
> Used for percpu variable updates. Local atomic operations only guarantee
> variable modification atomicity wrt the CPU which owns the data and
> these needs to be executed in a preemption safe way.

This is looking really nice. I like how you're able to specify
the mask nicely in the handler, and test the mask without adding
any instructions to fastpaths.

So far, I only have a few trivial nitpicks as you can see. I'll
apply the series and give it a more careful look tomorrow.

Thanks,
Nick
