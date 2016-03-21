Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT6jx2KCPzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 18:23:01 +1100 (AEDT)
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qT6jw5gWmz9s3s
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2016 18:23:00 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id x3so254778747pfb.1
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2016 00:23:00 -0700 (PDT)
Date: Mon, 21 Mar 2016 12:52:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 pc@us.ibm.com, shreyas@linux.vnet.ibm.com, anton@samba.org,
 mikey@neuling.org
Subject: Re: [PATCH] cpufreq: powernv: Define per_cpu chip pointer to
 optimize hot-path
Message-ID: <20160321072255.GB1803@vireshk-i7>
References: <1458274308.6622.79.camel@neuling.org>
 <1458313100-27676-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458313100-27676-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18-03-16, 20:28, Shilpasri G Bhat wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> "cpufreq: powernv: Remove cpu_to_chip_id() from hot-path" introduced

If the patch is already committed, you should provide its commit id as well.

> 'core_to_chip_map' array to cache the chip-id of all cores. Replace
> this with per_cpu variable that stores the pointer to the chip-array.
> This removes the linear lookup and provides a neater and simpler
> solution.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

You are sending this patch and you have updated it as well.. So, you should have
had your signed-off here.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
