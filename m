Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80F8F1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 19:18:47 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CC20B140B96
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 19:18:46 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 01:18:45 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 290F21FF0043
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 01:06:53 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0S8Ighu31850746
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 01:18:42 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0S8IeG6002785
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 01:18:42 -0700
Date: Thu, 28 Jan 2016 13:48:35 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH v7 5/6] cpufreq: powernv: Replace pr_info with trace
 print for throttle event
Message-ID: <20160128081835.GC13654@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453965941-7363-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 28, 2016 at 12:55:40PM +0530, Shilpasri G Bhat wrote:
> Currently we use printk message to notify the throttle event. But this
> can flood the console if the cpu is throttled frequently. So replace the
> printk with the tracepoint to notify the throttle event. And also events
> like throttle below nominal frequency and OCC_RESET are reduced to
> pr_warn/pr_warn_once as pointed by MFG to not mark them as critical
> messages. This patch adds 'throttle_reason' to struct chip to store the
> throttle reason.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.
