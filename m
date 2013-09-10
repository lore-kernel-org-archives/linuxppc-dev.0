Return-Path: <shawn.guo@linaro.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BAB302C0116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 21:19:51 +1000 (EST)
Date: Tue, 10 Sep 2013 19:19:50 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v4 12/19] cpufreq: cpufreq-cpu0: remove device tree
 parsing for cpu nodes
Message-ID: <20130910111947.GH5815@S2101-09.ap.freescale.net>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <Pine.LNX.4.64.1309061539310.11068@axis700.grange>
 <522D93D7.4010307@arm.com>
 <20130909143253.GD4624@S2101-09.ap.freescale.net>
 <522DE822.3030907@arm.com>
 <20130910024404.GC5815@S2101-09.ap.freescale.net>
 <522EFAD1.4020709@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <522EFAD1.4020709@arm.com>
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 10, 2013 at 11:56:17AM +0100, Sudeep KarkadaNagesha wrote:
> > So we only need to change all clkdev registration to use "cpu0" as
> > dev_id intstead of "cpufreq-cpu0.0", something like below.
> > 
> > And for imx, it should work even without the changes, because we have
> > device tree lookup ready there, and those clk_register_clkdev() calls
> > can just be removed now.  But I prefer to include the change and leave
> > the cleanup to another patch for keeping the change log clear.
> > 
> Ok makes sense, do you want me to include this patch also as fix.
> I can send a series to fix this if you OK:
> 1. Fix in cpufreq-cpu0
> 2. Fix in i.MX driver and platform file
> 3. Patch below

Yes, please.  Thanks.

Shawn
