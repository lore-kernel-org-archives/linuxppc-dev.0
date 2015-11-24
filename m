Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0144.outbound.protection.outlook.com [157.56.111.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 011791A0014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 01:18:33 +1100 (AEDT)
Message-ID: <1448374697.27264.308.camel@freescale.com>
Subject: Re: [PATCH] cpufreq: qoriq: Register cooling device based on device
 tree
From: Scott Wood <scottwood@freescale.com>
To: Jia Hongtao <hongtao.jia@freescale.com>, <edubezval@gmail.com>,
 <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>
Date: Tue, 24 Nov 2015 08:18:17 -0600
In-Reply-To: <1448348129-46675-1-git-send-email-hongtao.jia@freescale.com>
References: <1448348129-46675-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-24 at 14:55 +0800, Jia Hongtao wrote:
> Register the qoriq cpufreq driver as a cooling device, based on the
> thermal device tree framework. When temperature crosses the passive trip
> point cpufreq is used to throttle CPUs.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Reviewed-by: Scott Wood <scottwood@freescale.com>

When did I add "Reviewed-by" to this?

-Scott
