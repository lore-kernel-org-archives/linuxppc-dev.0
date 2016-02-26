Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46EC31A0B56
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 21:45:04 +1100 (AEDT)
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 790B11402D6
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 21:45:03 +1100 (AEDT)
Received: by mail-pa0-x22b.google.com with SMTP id fy10so49315432pac.1
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 02:45:03 -0800 (PST)
Date: Fri, 26 Feb 2016 16:15:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com
Subject: Re: [PATCH v10 1/2] cpufreq: powernv: Fix bugs in
 powernv_cpufreq_{init/exit}
Message-ID: <20160226104500.GH5823@vireshk-i7>
References: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1456483012-29466-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456483012-29466-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26-02-16, 16:06, Shilpasri G Bhat wrote:
> Unregister the notifiers if cpufreq_driver_register() fails in
> powernv_cpufreq_init(). Re-arrange the unregistration and cleanup routines
> in powernv_cpufreq_exit() to free all the resources after the driver
> has unregistered.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 40 ++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
