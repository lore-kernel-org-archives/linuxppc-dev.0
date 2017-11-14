Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblFr4pLTzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:00 +1100 (AEDT)
In-Reply-To: <20170823185841.25286-1-svaidy@linux.vnet.ibm.com>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: powerpc/powernv/idle: Round up latency and residency values
Message-Id: <3yblFr32fbz9t0F@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-23 at 18:58:41 UTC, Vaidyanathan Srinivasan wrote:
> On PowerNV platforms, firmware provides exit latency and
> target residency for each of the idle states in nano
> seconds.  Cpuidle framework expects the values in micro
> seconds.  Round up to nearest micro seconds to avoid errors
> in cases where the values are defined as fractional micro
> seconds.
> 
> Default idle state of 'snooze' has exit latency of zero.  If
> other states have fractional micro second exit latency, they
> would get rounded down to zero micro second and make cpuidle
> framework choose deeper idle state when snooze loop is the
> right choice.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8d4e10e9ed9450e18fbbf6a8872be0

cheers
