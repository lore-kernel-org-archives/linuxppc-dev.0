Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFB5LJqzDrJp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:50 +1000 (AEST)
In-Reply-To: <1501704846-22625-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: [v3,
 1/2] powerpc/xmon: Dump ftrace buffers for the current CPU only
Message-Id: <3xXTFB2V0Zz9t5W@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 20:14:05 UTC, Breno Leitao wrote:
> Current xmon 'dt' command dumps the tracing buffer for all the CPUs,
> which makes it very hard to read due to the fact that most of
> powerpc machines currently have many CPUs. Other than that, the CPU
> lines are interleaved in the ftrace log.
> 
> This new option just dumps the ftrace buffer for the current CPU.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4125d012ff9dafe6624197d8dbd237

cheers
