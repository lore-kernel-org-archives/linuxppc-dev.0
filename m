Return-Path: <rjw@rjwysocki.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVjRl134lzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 08:31:15 +1100 (AEDT)
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 3qVjGd4kmPz9sBf
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2016 08:23:20 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, shreyas@linux.vnet.ibm.com,
 linux-api@vger.kernel.org
Subject: Re: [PATCH v13] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Date: Wed, 23 Mar 2016 22:25:31 +0100
Message-ID: <6318383.4ce58n55jt@vostro.rjw.lan>
In-Reply-To: <20160322142507.GK5272@vireshk-i7>
References: <1458653229-10318-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160322142507.GK5272@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, March 22, 2016 07:55:07 PM Viresh Kumar wrote:
> On 22-03-16, 18:57, Shilpasri G Bhat wrote:
> > Create sysfs attributes to export throttle information in
> > /sys/devices/system/cpu/cpuX/cpufreq/throttle_stats directory. The
> > newly added sysfs files are as follows:
> > 
> > 1)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/turbo_stat
> > 2)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/sub-turbo_stat
> > 3)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/unthrottle
> > 4)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/powercap
> > 5)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/overtemp
> > 6)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/supply_fault
> > 7)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/overcurrent
> > 8)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/occ_reset
> > 
> > Detailed explanation of each attribute is added to
> > Documentation/ABI/testing/sysfs-devices-system-cpu
> > 
> > CC: linux-api@vger.kernel.org
> > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > ---
> > Changes from v12:
> > - Removed (void *) typecast
> > - Move the definition of ret inside the 'if' block
> 
> Sorry for 12 versions :)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
