Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492DA1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 20:41:51 +1100 (AEDT)
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AE51C14030F
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:41:50 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id n128so20820564pfn.3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 01:41:50 -0800 (PST)
Date: Thu, 28 Jan 2016 15:11:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v7 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160128094146.GO3935@vireshk>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160128084041.GK3935@vireshk>
 <56A9E136.8090900@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A9E136.8090900@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28-01-16, 15:06, Shilpasri G Bhat wrote:
> No these stats are not per-policy. They are per-chip. The throttle event is
> common for all cores in the chip.

How do you define a chip? And how is it different then the group of
CPUs represented by the policy ?

-- 
viresh
