Return-Path: <gregkh@linuxfoundation.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BDF31A186B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 09:23:15 +1100 (AEDT)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E3C7114032F
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 09:23:14 +1100 (AEDT)
Date: Mon, 11 Jan 2016 14:23:12 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org,
 ego@linux.vnet.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/4] cpufreq: powernv: Redesign the presentation of
 throttle notification
Message-ID: <20160111222312.GA3967@kroah.com>
References: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 11, 2016 at 02:54:36PM -0600, Shilpasri G Bhat wrote:
> In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
> CPU when the chip crosses its thermal and power limits. Currently,
> powernv-cpufreq driver detects and reports this event as a console
> message. Some machines may not sustain the max turbo frequency in all
> conditions and can be throttled frequently. This can lead to the
> flooding of console with throttle messages. So this patchset aims to
> redesign the presentation of this event via sysfs counters and
> tracepoints. 
> 
> Patches [2] to [4] will add a perf trace point "power:powernv_throttle" and
> sysfs throttle counter stats in /sys/devices/system/cpu/cpufreq/chipN.
> Patch [1] solves a bug in powernv_cpufreq_throttle_check(), which calls in to
> cpu_to_chip_id() in hot path which reads DT every time to find the chip id.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
