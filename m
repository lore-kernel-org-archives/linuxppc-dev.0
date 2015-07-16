Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D0F91A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 15:14:15 +1000 (AEST)
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0AAF9140285
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 15:14:13 +1000 (AEST)
Received: by pacan13 with SMTP id an13so36504429pac.1
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2015 22:14:11 -0700 (PDT)
Date: Thu, 16 Jul 2015 10:44:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/6] powernv: cpufreq: Report frequency throttle by OCC
Message-ID: <20150716051407.GB15404@linux>
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13-07-15, 19:39, Shilpasri G Bhat wrote:
> This patchset intends to add frequency throttle reporting mechanism
> to powernv-cpufreq driver when OCC throttles the frequency. OCC is an
> On-Chip-Controller which takes care of the power and thermal safety of
> the chip. The CPU frequency can be throttled during an OCC reset or
> when OCC tries to limit the max allowed frequency. The patchset will
> report such conditions so as to keep the user informed about reason
> for the drop in performance of workloads when frequency is throttled.
> 
> Changes from v3:
> - Rebased on top of 4.2-rc1
> - Minor changes in patch 2,3,4,6 this does not change the
>   functionality of the code
> - 594fcb9ec9e powerpc/powernv: Expose OPAL APIs required by PRD
>   interface , this patch fixes the build error due to which this
>   series was initially dropped
>   ERROR: ".opal_message_notifier_register"
>   drivers/cpufreq/powernv-cpufreq.ko] undefined!

I have already Acked v3 of this and that applies to this one as well..

-- 
viresh
