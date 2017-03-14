Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjCbz3cN5zDqpw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:45:51 +1100 (AEDT)
In-Reply-To: <1487598990-28592-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Fix perf_get_data_addr() for power9 DD1
Message-Id: <3vjCbz2xTPz9s3l@ozlabs.org>
Date: Tue, 14 Mar 2017 22:45:51 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-20 at 13:56:30 UTC, Madhavan Srinivasan wrote:
> Power9 DD1 do not support PMU_HAS_SIER flag and sdsync
> in perf_get_data_addr() defaults to MMCRA_SDSYNC which
> is wrong. Since power9 MMCRA does not support SDSYNC bit,
> patch includes PPMU_NO_SIAR flag to the check and set the
> sdsync with MMCRA_SAMPLE_ENABLE;
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f04d108029063a8a67528a88449c41

cheers
