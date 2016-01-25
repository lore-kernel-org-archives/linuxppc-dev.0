Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C8241A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:58:14 +1100 (AEDT)
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC9BF1402A1
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 16:58:13 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id q63so78608140pfb.1
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jan 2016 21:58:13 -0800 (PST)
Date: Mon, 25 Jan 2016 11:28:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
Subject: Re: [PATCH v6 4/5] cpufreq: powernv: Replace pr_info with trace
 print for throttle event
Message-ID: <20160125055809.GC3183@vireshk>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453447145-17722-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453447145-17722-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22-01-16, 12:49, Shilpasri G Bhat wrote:
> Currently we use printk message to notify the throttle event. But this
> can flood the console if the cpu is throttled frequently. So replace the
> printk with the tracepoint to notify the throttle event. And also events
> like throttle below nominal frequency and OCC_RESET are reduced to
> pr_warn/pr_warn_once as pointed by MFG to not mark them as critical
> messages. This patch adds 'throt_reason' to struct chip to store the
> throttle reason.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> No changes from v5.

You have done too many things in a single patch, its always better to
keep a patch for a special problem. Don't try to solve everything in
the same patch.

Though, I am NOT strongly saying that you respin this patch now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
