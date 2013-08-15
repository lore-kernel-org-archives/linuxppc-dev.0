Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 459B92C0238
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 08:14:52 +1000 (EST)
Message-ID: <1376604872.4255.115.camel@pasglop>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 16 Aug 2013 08:14:32 +1000
In-Reply-To: <20130815201000.GB3067@blackmetal.musicnaut.iki.fi>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
 <9298823.WUCyZreP9q@vostro.rjw.lan> <1374614043.3916.84.camel@pasglop>
 <1376269668.32100.148.camel@pasglop>
 <20130815201000.GB3067@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nick Piggin <npiggin@suse.de>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Viresh Kumar <viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-15 at 23:10 +0300, Aaro Koskinen wrote:

> I guess we should keep the current 12us latency in g5_neo2_cpufreq_init()
> (although I doubt it's correct...), and only add the new 10ms latency
> value to g5_pm72_cpufreq_init() - that way we can enable the older systems
> to use ondemand (despite long latencies), while not risking regressing
> any of the current functionality.
> 
> I'll resend the series with the changes.

Well, mine is a 11,2, it's not a neo2.

I suppose we could try to measure the latency :-)

Cheers,
Ben.
