Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-x230.google.com (mail-oa0-x230.google.com
 [IPv6:2607:f8b0:4003:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F4772C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 20:36:33 +1000 (EST)
Received: by mail-oa0-f48.google.com with SMTP id i4so954971oah.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jun 2013 03:36:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370424648-1082-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1370424648-1082-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Wed, 5 Jun 2013 16:06:29 +0530
Message-ID: <CAKohpokM_THCQRPfrsNcuN_MUe75BCsoeZWkK9gv7+3nAL2SRQ@mail.gmail.com>
Subject: Re: [PATCH v5] cpufreq: powerpc: Add cpufreq driver for Freescale
 e500mc SoCs
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuantian.Tang@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: rjw@sisk.pl, linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5 June 2013 15:00,  <Yuantian.Tang@freescale.com> wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
>
> Add cpufreq driver for Freescale e500mc, e5500 and e6500 SoCs
> which are capable of changing the CPU frequency dynamically
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> v5:
>         - enhance the CPU hotplug case
>         - mask the disallowed CPU frequencies
>         - remove freqs.cpu = policy->cpu;
>         - refine the code style
> v4:
>         - rebase on bleeding-edge branch of Rafael's linux-pm.git
>         - #define pr_fmt() for better debug prints
>         - use newest cpufreq_notify_transition()
>         - support CPU hotplug
>         - remove table[i].index as it is not used
>         - remove cpus_per_cluster
> v3:
>         - change sizeof(struct name).. to sizeof(*p)
>         - remove the struct cpufreq_data, use global variable instead
>         - resolve setting policy->cpus incorrectly
>         - add CPUFREQ_POSTCHANGE notifier when setting frequency error
> v2:
>         - add depends on OF and COMMON_CLK in Kconfig
>         - use clk.h instead of clk-provider.h
>         - change per_cpu variable from struct to pointer
>
>  drivers/cpufreq/Kconfig.powerpc       |  10 +
>  drivers/cpufreq/Makefile              |   1 +
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 380 ++++++++++++++++++++++++++++++++++
>  3 files changed, 391 insertions(+)
>  create mode 100644 drivers/cpufreq/ppc-corenet-cpufreq.c

I haven't gone for a very deep review this time and it looked okay.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
