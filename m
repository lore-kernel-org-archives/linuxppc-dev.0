Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7bd25HZ2zDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 08:04:22 +1000 (AEST)
In-Reply-To: <1492498887-10006-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2] powerpc/mm: Update mm context addr limit correctly.
Message-Id: <3w7bd23wKnz9s7t@ozlabs.org>
Date: Thu, 20 Apr 2017 08:04:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-18 at 07:01:27 UTC, "Aneesh Kumar K.V" wrote:
> We added the addr < TASK_SIZE check to avoid updating addr_limit unnecessarily and
> also to avoid calling slice_flush_segments on all the cpus. This had the side
> effect of having different behaviour when using an addr value above TASK_SIZE
> before updating addr_limit and after updating addr_limit as show by below
> output:
...
> 
> This also bring the ABI in-line with what is proposed on x86. ie, to use
> a hint addr above 128TB up to and including (2^64)-1 as an indication to search
> the full address space.
> 
> Fixes: f4ea6dcb08ea2c (powerpc/mm: Enable mappings above 128TB)
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/321f7d29e5163d7f1c9c0b705acc45

cheers
