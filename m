Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0742BB6F92
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 05:02:24 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pA3I1JUs023424
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Nov 2011 13:02:21 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1251.1)
Subject: Re: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard SMP id
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1318578771-16865-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 3 Nov 2011 13:02:20 -0500
Message-Id: <4144C592-29A6-4DE1-9A20-EC94538496F2@kernel.crashing.org>
References: <1318578771-16865-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 14, 2011, at 2:52 AM, Kumar Gala wrote:

> Normally logical and hard cpu ID are the same, however in same cases like
> on the P3060 they may differ.  Where the logical is 0..5, the hard id
> goes 0,1,4..7.  This can causes issues for places we utilize PIR to index
> into array like in debug exception handlers for finding the exception
> stack.
> 
> Move to setting up PIR with hard_smp_processor_id fixes the issue.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/platforms/85xx/smp.c |    9 +++++----
> 1 files changed, 5 insertions(+), 4 deletions(-)

applied

- k
