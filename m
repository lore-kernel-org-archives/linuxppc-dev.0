Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3rgKyg21xLzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 23:24:42 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Scott Wood <scott.wood@nxp.com>
Cc: Yuantian Tang <yuantian.tang@nxp.com>, Scott Wood <oss@buserror.net>,
 Russell King <linux@armlinux.org.uk>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Yang-Leo Li <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
Date: Thu, 30 Jun 2016 15:29:06 +0200
Message-ID: <3794032.AoZL3DhM7U@vostro.rjw.lan>
In-Reply-To: <DB5PR0401MB1928B6A4F1049592292D348C91240@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <DBXPR04MB4951CA4EFB4FB5A2BDE7542F0240@DBXPR04MB495.eurprd04.prod.outlook.com>
 <DB5PR0401MB1928B6A4F1049592292D348C91240@DB5PR0401MB1928.eurprd04.prod.outlook.com>
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

On Thursday, June 30, 2016 05:46:42 AM Scott Wood wrote:
> On 06/29/2016 10:02 PM, Yuantian Tang wrote:
> >> -----Original Message-----
> >> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> >> Sent: Thursday, June 30, 2016 10:24 AM
> >> To: Yuantian Tang <yuantian.tang@nxp.com>
> >> Cc: Scott Wood <oss@buserror.net>; Russell King <linux@armlinux.org.uk>;
> >> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> >> <sboyd@codeaurora.org>; Viresh Kumar <viresh.kumar@linaro.org>; linux-
> >> clk@vger.kernel.org; linux-pm@vger.kernel.org; linuxppc-
> >> dev@lists.ozlabs.org; Yang-Leo Li <leoyang.li@nxp.com>; Xiaofeng Ren
> >> <xiaofeng.ren@nxp.com>; Scott Wood <scottwood@freescale.com>
> >> Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
> >> parent clocks
> >>
> >> On Thursday, June 30, 2016 01:47:09 AM Yuantian Tang wrote:
> >>>> -----Original Message-----
> >>>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> >>>> Sent: Thursday, June 30, 2016 9:47 AM
> >>>> To: Yuantian Tang <yuantian.tang@nxp.com>
> >>>> Cc: Scott Wood <oss@buserror.net>; Russell King
> >>>> <linux@armlinux.org.uk>; Michael Turquette
> >>>> <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeaurora.org>;
> >>>> Viresh Kumar <viresh.kumar@linaro.org>; linux- clk@vger.kernel.org;
> >>>> linux-pm@vger.kernel.org; linuxppc- dev@lists.ozlabs.org; Yang-Leo
> >>>> Li <leoyang.li@nxp.com>; Xiaofeng Ren <xiaofeng.ren@nxp.com>; Scott
> >>>> Wood <scottwood@freescale.com>
> >>>> Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering
> >>>> possible parent clocks
> >>>>
> >>>> On Wednesday, June 29, 2016 05:50:26 AM Yuantian Tang wrote:
> >>>>> Hi,
> >>>>>
> >>>>> This patch is acked by clock maintainer. If no comments from
> >>>>> anyone else,
> >>>> we will merge it in next week.
> >>>>
> >>>> There is a cpufreq commit depending on it.  Are you going to handle
> >>>> that one too?
> >>>>
> >>> That one has been acked by cpufreq maintainer. You can get this from
> >> patch comments.
> >>
> >> I know that it has been ACKed.
> >>
> >> My question is whether or not you are going to apply it along the [1/2].
> >>
> >> If not, it will have to be deferred until the [1/2] is merged and then applied
> >> which may not be desirable.
> >>
> > I hope we can apply both at same time. Seems Scott has a few concerns.
> > 
> > What you think about this patch? Can you apply it?
> > If you have applied this patch, then I can push CPUfreq maintainer to apply another one which will be delayed.
> 
> My only concern was getting an ack for this patch (1/2) -- did I miss it
> somewhere?

OK, so who's going to apply the series?

Thanks,
Rafael
