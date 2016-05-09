Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3RFk3VNwzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 01:32:10 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id xk12so74295938pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 May 2016 08:32:10 -0700 (PDT)
Date: Mon, 9 May 2016 21:02:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH-next v2 0/2] cpufreq: powernv: Fixes for Global pstate
 management
Message-ID: <20160509153204.GA21661@vireshk-i7>
References: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-05-16, 20:49, Akshay Adiga wrote:
> Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which
> is in Rafael's linux-next.
> 
> - Patch [1] fixes WARN_ON in powernv_target_index()
> - Patch [2] Deleting any pending timer to saves an unnecessary irq call
>  in powernv_target_index()
> 
> Akshay Adiga (2):
>   cpufreq: powernv: Move smp_call_function_any() out of irq safe block
>   cpufreq: powernv: del_timer_sync when global and local pstate are
>     equal

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
