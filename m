Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtk4fShzDrbn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:38 +1100 (AEDT)
In-Reply-To: <1511327739-21688-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anju@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [1/2] powerpc/perf: Fix pmu_count to count only nest imc pmus
Message-Id: <3yjrtk1Wycz9t20@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:37 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-11-22 at 05:15:38 UTC, Madhavan Srinivasan wrote:
> "pmu_count" in opal_imc_counters_probe() is intended to hold
> the number of successful nest imc pmu registerations. But
> current code also counts other imc units like core_imc and
> thread_imc. Patch add a check to count only nest imc pmus.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/de34787f1096cce38e2590be0013b4

cheers
