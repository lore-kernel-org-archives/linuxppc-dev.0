Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC6Cx17JzzDt0f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 20:12:45 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id 189so88645647pfz.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 01:12:45 -0800 (PST)
Date: Mon, 7 Nov 2016 14:42:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com,
 shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] cpufreq: powernv: Adding fast_switch for schedutil
Message-ID: <20161107091240.GG21030@vireshk-i7>
References: <1478504349-14796-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478504349-14796-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07-11-16, 13:09, Akshay Adiga wrote:
> Adding fast_switch which does light weight operation to set the desired
> pstate. Both global and local pstates are set to the same desired pstate.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
> Changes from v1 :
> - Removed unnecessary check for index out of bound.

Provided Gautham/Shilpa find these patches fine..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
