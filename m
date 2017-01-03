Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pg0-x232.google.com (mail-pg0-x232.google.com
 [IPv6:2607:f8b0:400e:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttB5r3Y9kzDqDx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 22:09:04 +1100 (AEDT)
Received: by mail-pg0-x232.google.com with SMTP id y62so161907827pgy.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 03:09:04 -0800 (PST)
Date: Tue, 3 Jan 2017 16:38:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH V2] cpufreq: powernv: Add boost files to export
 ultra-turbo frequencies
Message-ID: <20170103110859.GB14137@vireshk-i7>
References: <1483441560-11957-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483441560-11957-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-01-17, 16:36, Shilpasri G Bhat wrote:
> In P8+, Workload Optimized Frequency(WOF) provides the capability to
> boost the cpu frequency based on the utilization of the other cpus
> running in the chip. The On-Chip-Controller(OCC) firmware will control
> the achievability of these frequencies depending on the power headroom
> available in the chip. Currently the ultra-turbo frequencies provided
> by this feature are exported along with the turbo and sub-turbo
> frequencies as scaling_available_frequencies. This patch will export
> the ultra-turbo frequencies separately as scaling_boost_frequencies in
> WOF enabled systems. This patch will add the boost sysfs file which
> can be used to disable/enable ultra-turbo frequencies.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> Changes from v1:
> - Print if WOF is enabled
> - s/clean_notifiers/cleanup_notifiers
> 
>  drivers/cpufreq/powernv-cpufreq.c | 50 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
