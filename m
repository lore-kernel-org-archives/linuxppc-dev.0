Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYHyS685JzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 13:33:19 +1100 (AEDT)
Received: by mail-pf0-x22d.google.com with SMTP id x3so126133367pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:33:19 -0700 (PDT)
Date: Mon, 28 Mar 2016 08:03:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Christian Krafft <krafft@de.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] drivers/cpufreq: make ppc_cbe_cpufreq_pmi driver
 explicitly non-modular
Message-ID: <20160328023314.GA28406@vireshk-i7>
References: <1459116497-19991-1-git-send-email-paul.gortmaker@windriver.com>
 <1459116497-19991-4-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459116497-19991-4-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27-03-16, 18:08, Paul Gortmaker wrote:
> The Kconfig for this driver is currently:
> 
> config CPU_FREQ_CBE_PMI
>     bool "CBE frequency scaling using PMI interface"
> 
> ...meaning that it currently is not being built as a module by
> anyone.  Lets remove the modular and unused code here, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Christian Krafft <krafft@de.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
