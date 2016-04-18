Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpPCf65ryzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:15:10 +1000 (AEST)
Received: by mail-pa0-x22f.google.com with SMTP id er2so49107510pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 03:15:10 -0700 (PDT)
Date: Mon, 18 Apr 2016 15:45:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] cpufreq: powernv: Remove flag use-case of
 policy->driver_data
Message-ID: <20160418101505.GA2322@vireshk-i7>
References: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460701739-31549-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460701739-31549-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15-04-16, 11:58, Akshay Adiga wrote:
> From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> 
> commit 1b0289848d5d ("cpufreq: powernv: Add sysfs attributes to show
> throttle stats") used policy->driver_data as a flag for one-time creation
> of throttle sysfs files. Instead of this use 'kernfs_find_and_get()' to
> check if the attribute already exists. This is required as
> policy->driver_data is used for other purposes in the later patch.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
