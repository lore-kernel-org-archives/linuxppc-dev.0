Return-Path: <viresh.kumar@linaro.org>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD7931A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 20:08:11 +1100 (AEDT)
Received: by iouu10 with SMTP id u10so82245997iou.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 01:08:09 -0800 (PST)
Date: Thu, 26 Nov 2015 14:38:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 scottwood@freescale.com
Subject: Re: [PATCH V2] cpufreq: qoriq: Register cooling device based on
 device tree
Message-ID: <20151126090805.GJ3869@ubuntu>
References: <1448519249-11449-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448519249-11449-1-git-send-email-hongtao.jia@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26-11-15, 14:27, Jia Hongtao wrote:
> +static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct cpu_data *cpud = policy->driver_data;
> +	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
> +
> +	if (WARN_ON(!np))
> +		return;

Drop this and add my:

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
