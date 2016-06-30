Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3rg2NV2zbgzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:42:33 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yuantian Tang <yuantian.tang@nxp.com>
Cc: Scott Wood <oss@buserror.net>, Russell King <linux@armlinux.org.uk>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Yang-Leo Li <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
Date: Thu, 30 Jun 2016 03:46:56 +0200
Message-ID: <2091721.Cm4CVR1ptK@vostro.rjw.lan>
In-Reply-To: <DBXPR04MB49546917495DA33834B05D7F0230@DBXPR04MB495.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <DBXPR04MB49546917495DA33834B05D7F0230@DBXPR04MB495.eurprd04.prod.outlook.com>
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

On Wednesday, June 29, 2016 05:50:26 AM Yuantian Tang wrote:
> Hi,
> 
> This patch is acked by clock maintainer. If no comments from anyone else, we will merge it in next week.

There is a cpufreq commit depending on it.  Are you going to handle that one too?

Thanks,
Rafael
