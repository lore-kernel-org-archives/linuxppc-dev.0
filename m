Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3MQd1Hm5zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 22:39:36 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Mon, 9 May 2016 22:39:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8CEF7357805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 22:39:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u49CdPaK63439052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 May 2016 22:39:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u49Cd0cj003922
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 May 2016 22:39:00 +1000
Subject: Re: [PATCH-next v2 0/2] cpufreq: powernv: Fixes for Global pstate
 management
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Message-ID: <573084CA.6020708@linux.vnet.ibm.com>
Date: Mon, 9 May 2016 18:08:34 +0530
MIME-Version: 1.0
In-Reply-To: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 08:49 PM, Akshay Adiga wrote:

> Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which
> is in Rafael's linux-next.
>
> - Patch [1] fixes WARN_ON in powernv_target_index()
> - Patch [2] Deleting any pending timer to saves an unnecessary irq call
>   in powernv_target_index()
>
> Akshay Adiga (2):
>    cpufreq: powernv: Move smp_call_function_any() out of irq safe block
>    cpufreq: powernv: del_timer_sync when global and local pstate are
>      equal
>
>   drivers/cpufreq/powernv-cpufreq.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
Does this look good ? Anything i should do ?


Regards
Akshay Adiga
