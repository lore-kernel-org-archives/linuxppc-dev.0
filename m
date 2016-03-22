Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTw2f0lj9zDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 01:25:14 +1100 (AEDT)
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qTw2d2Pprz9s9W
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 01:25:12 +1100 (AEDT)
Received: by mail-pf0-x236.google.com with SMTP id 4so182760862pfd.0
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2016 07:25:12 -0700 (PDT)
Date: Tue, 22 Mar 2016 19:55:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 shreyas@linux.vnet.ibm.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v13] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160322142507.GK5272@vireshk-i7>
References: <1458653229-10318-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458653229-10318-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22-03-16, 18:57, Shilpasri G Bhat wrote:
> Create sysfs attributes to export throttle information in
> /sys/devices/system/cpu/cpuX/cpufreq/throttle_stats directory. The
> newly added sysfs files are as follows:
> 
> 1)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/turbo_stat
> 2)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/sub-turbo_stat
> 3)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/unthrottle
> 4)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/powercap
> 5)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/overtemp
> 6)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/supply_fault
> 7)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/overcurrent
> 8)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/occ_reset
> 
> Detailed explanation of each attribute is added to
> Documentation/ABI/testing/sysfs-devices-system-cpu
> 
> CC: linux-api@vger.kernel.org
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from v12:
> - Removed (void *) typecast
> - Move the definition of ret inside the 'if' block

Sorry for 12 versions :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
