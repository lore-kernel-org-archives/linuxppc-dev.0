Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 614321A03F9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:43:32 +1100 (AEDT)
In-Reply-To: <1453447145-17722-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
 rjw@rjwysocki.net, pc@us.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com,
 anton@samba.org
Subject: Re: [v6,
 5/5] cpufreq: powernv: Add sysfs attributes to show throttle stats
Message-Id: <20160125054332.0D7D6140326@ozlabs.org>
Date: Mon, 25 Jan 2016 16:43:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-22-01 at 07:19:05 UTC, Shilpasri G Bhat wrote:
> Create sysfs attributes to export throttle information in
> /sys/devices/system/cpu/cpufreq/chipN. The newly added sysfs files are as
> follows:
> 
> 1)/sys/devices/system/cpu/cpufreq/chip0/throttle_frequencies
..
> 2)/sys/devices/system/cpu/cpufreq/chip0/throttle_reasons
..
> 3)/sys/devices/system/cpu/cpufreq/chip0/throttle_stat
..

These should all be added to Documentation/ABI/testing/sysfs-devices-system-cpu.

cheers
