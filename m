Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpzmD4GgzzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:11:55 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id e128so4940448pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 02:11:55 -0700 (PDT)
Date: Tue, 19 Apr 2016 14:41:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 scott.wood@nxp.com, yuantian.tang@nxp.com
Subject: Re: [PATCH V3 1/2] cpufreq: qoriq: Remove __exit macro from .exit
 callback
Message-ID: <20160419091151.GA2905@vireshk-i7>
References: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19-04-16, 17:00, Jia Hongtao wrote:
> .exit callback (qoriq_cpufreq_cpu_exit()) is also used during suspend.
> So __exit macro should be removed or the function will be discarded.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
