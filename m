Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 90D492C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 11:08:06 +1000 (EST)
Message-ID: <1376269668.32100.148.camel@pasglop>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 12 Aug 2013 11:07:48 +1000
In-Reply-To: <1374614043.3916.84.camel@pasglop>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
 <9298823.WUCyZreP9q@vostro.rjw.lan> <1374614043.3916.84.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-24 at 07:14 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-07-23 at 23:20 +0200, Rafael J. Wysocki wrote:
> > All looks good in the patchset from 10000 feet (or more), but I need
> > Ben to speak here.
> 
> I want to give it a quick spin on the HW here, I'll ack then. But yes,
> it looks good.

Seems to work here on the quad G5.

However, If I use on-demand, there's a huge latency of switch as far as
I can tell (about 10s) after I start/stop a bunch of CPU eaters... I
quite like how the userspace "powernowd" which I used to use switches
more aggressively.

Is that expected ?

Cheers,
Ben.
