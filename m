Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F392E2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 07:14:21 +1000 (EST)
Message-ID: <1374614043.3916.84.camel@pasglop>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 24 Jul 2013 07:14:03 +1000
In-Reply-To: <9298823.WUCyZreP9q@vostro.rjw.lan>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
 <9298823.WUCyZreP9q@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-23 at 23:20 +0200, Rafael J. Wysocki wrote:
> All looks good in the patchset from 10000 feet (or more), but I need
> Ben to speak here.

I want to give it a quick spin on the HW here, I'll ack then. But yes,
it looks good.

Cheers,
Ben.
