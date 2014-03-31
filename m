Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A68321400E1
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2014 15:21:06 +1100 (EST)
Received: by mail-ob0-f169.google.com with SMTP id va2so8665559obc.0
 for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2014 21:21:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1396037484-23907-2-git-send-email-ego@linux.vnet.ibm.com>
References: <1396037484-23907-1-git-send-email-ego@linux.vnet.ibm.com>
 <1396037484-23907-2-git-send-email-ego@linux.vnet.ibm.com>
Date: Mon, 31 Mar 2014 09:51:03 +0530
Message-ID: <CAKohpokvHYH7xcQyQyKmbu_xqfX8dbwnBNhQ3y9ZyAm7i0z0Qg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] powernv, cpufreq: Select CPUFreq related Kconfig
 options for powernv
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29 March 2014 01:41, Gautham R. Shenoy <ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> Enable CPUFreq for PowerNV. Select "performance", "powersave",
> "userspace" and "ondemand" governors. Choose "ondemand" to be the
> default governor.
>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>  arch/powerpc/configs/pseries_defconfig    | 1 +
>  arch/powerpc/configs/pseries_le_defconfig | 1 +
>  arch/powerpc/platforms/powernv/Kconfig    | 6 ++++++
>  3 files changed, 8 insertions(+)

Probably it doesn't make much sense to keep this as the first patch
as you still don't have the driver available yet.
