Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fQ5RCJzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:10 +1000 (AEST)
In-Reply-To: <1459116497-19991-4-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 <linux-kernel@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Krafft <krafft@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/3] drivers/cpufreq: make ppc_cbe_cpufreq_pmi driver explicitly
 non-modular
Message-Id: <3qk8fQ3wrVz9t3p@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-27-03 at 22:08:17 UTC, Paul Gortmaker wrote:
> The Kconfig for this driver is currently:
> 
> config CPU_FREQ_CBE_PMI
>     bool "CBE frequency scaling using PMI interface"
> 
> ...meaning that it currently is not being built as a module by
> anyone.  Lets remove the modular and unused code here, so that
> when reading the driver there is no doubt it is builtin-only.
> 
...
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6a0bcab9c6c337e14689cabd27

cheers
