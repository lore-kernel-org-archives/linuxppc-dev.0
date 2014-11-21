Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA17E1A1284
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 20:22:07 +1100 (AEDT)
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 57226140186
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 20:22:07 +1100 (AEDT)
Received: by mail-oi0-f41.google.com with SMTP id a3so3438475oib.0
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 01:22:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416561518-24835-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1416561518-24835-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Fri, 21 Nov 2014 14:52:05 +0530
Message-ID: <CAKohpokKJQV3-b-hqUz7pKgM+SVRBqW=tq54sxpkeAU=Pg73pQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: qoriq: Make the driver usable on all
 QorIQ platforms
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: r64188@freescale.com, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 November 2014 14:48, Tang Yuantian <Yuantian.Tang@freescale.com> wrote:
> Freescale introduced new ARM core-based SoCs which support dynamic
> frequency switch feature. DFS on new SoCs are compatible with current
> PowerPC CoreNet platforms. In order to support those new platforms,
> this driver needs to be updated. The main changes include:
>
> 1. Changed the names of functions in driver.
> 2. Added two new functions get_cpu_physical_id() and get_bus_freq().
> 3. Used a new way to get the CPU mask which share clock wire.
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> v3:
>         - put the menu entries into Kconfig
> v2:
>         - split the name change into a separete patch
>         - use policy->driver_data instead of per_cpu variable
>
>  drivers/cpufreq/Kconfig               |   8 ++
>  drivers/cpufreq/Kconfig.powerpc       |   9 --
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 160 +++++++++++++++++++++-------------
>  3 files changed, 107 insertions(+), 70 deletions(-)

For both patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
