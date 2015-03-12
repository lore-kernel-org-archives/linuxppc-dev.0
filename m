Return-Path: <rjw@rjwysocki.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 965F71A0394
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 10:01:27 +1100 (AEDT)
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id DE3241400EA
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2015 10:01:22 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yuantian.Tang@freescale.com
Subject: Re: [PATCH 1/2 v4] cpufreq: qoriq: Make the driver usable on all
 QorIQ platforms
Date: Fri, 13 Mar 2015 00:18:29 +0100
Message-ID: <2439490.9WNany9TAP@vostro.rjw.lan>
In-Reply-To: <1425353932-713-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1425353932-713-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, March 03, 2015 11:38:51 AM Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> Freescale introduced new ARM core-based SoCs which support dynamic
> frequency switch feature. DFS on new SoCs are compatible with current
> PowerPC CoreNet platforms. In order to support those new platforms,
> this driver needs to be updated. The main changes include:
> 
> 1. Changed the names of functions in driver.
> 2. Added two new functions get_cpu_physical_id() and get_bus_freq().
> 3. Used a new way to get the CPU mask which share clock wire.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

That doesn't apply for me on top of 4.0-rc3.  Can you please rebase and
resubmit?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
