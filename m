Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 2E04E1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 10:35:00 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: edubezval@gmail.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 scottwood@freescale.com
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Tue, 15 Dec 2015 00:58:26 +0100
Message-ID: <1697588.dLcbZBRWO4@vostro.rjw.lan>
In-Reply-To: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, November 26, 2015 05:21:11 PM Jia Hongtao wrote:
> Register the qoriq cpufreq driver as a cooling device, based on the
> thermal device tree framework. When temperature crosses the passive trip
> point cpufreq is used to throttle CPUs.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael
