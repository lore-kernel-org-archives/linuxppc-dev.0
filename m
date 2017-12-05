Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrVwx3FW1zF068
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 16:41:36 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id j124so10433923pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 21:41:36 -0800 (PST)
Date: Tue, 5 Dec 2017 11:11:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 svaidy@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 huntbag@linux.vnet.ibm.com, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: Define methods to parse positive &
 negative pstates
Message-ID: <20171205054130.vsr45ekas3f5k3cg@vireshk-mac-ubuntu>
References: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30-11-17, 10:13, Shilpasri G Bhat wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Pstates are 8bit values but on POWER8 they are negative and on POWER9
> they are positive. This patch adds helper routines to differentiate
> the sign to read the correct pstate value.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 43 ++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
