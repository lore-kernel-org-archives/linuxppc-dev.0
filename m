Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0789140165
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 19:04:57 +1000 (EST)
Date: Fri, 25 Apr 2014 10:03:43 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
Message-ID: <20140425090343.GH26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
 <20140424101726.GH26756@n2100.arm.linux.org.uk>
 <CAPDyKFrGReKF0ucer7D195boEoQW26=4vDXT+=Wn6BO-p_B1gQ@mail.gmail.com>
 <20140424105745.GM26756@n2100.arm.linux.org.uk>
 <CAPDyKFr=2=dg1NTYb1_EAgxXZq2Rd+o2Q2B5TE+GZwr8MUU1_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPDyKFr=2=dg1NTYb1_EAgxXZq2Rd+o2Q2B5TE+GZwr8MUU1_Q@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>,
 linux-doc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>,
 Chris Ball <chris@printf.net>, Thierry Reding <thierry.reding@gmail.com>,
 Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 spear-devel@list.st.com, Rob Herring <robh+dt@kernel.org>,
 Ben Dooks <ben-linux@fluff.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Shawn Guo <shawn.guo@freescale.com>, Barry Song <baohua@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Viresh Kumar <viresh.linux@gmail.com>, Sascha Hauer <kernel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2014 at 01:13:05PM +0200, Ulf Hansson wrote:
> On 24 April 2014 12:57, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > This is nothing new or unexpected - it was last posted back in February,
> > and I elected that it should be held off until after the last merge
> > window.
> >
> > Unfortunately, I didn't have time to post it immediately after the merge
> > window closed, partly because it needed to be rebased on top of tglx's
> > IRQ changes on which it depends.  I was carrying those as separate commits
> > to the ones Thomas was carrying in his tree - and in the event, Thomas had
> > modified his patches slightly between sending me copies of them and the
> > versions he sent during the merge window.
> 
> Okay, so let's keep up the frequency here then. I only had some minor
> comments, please fix them and send a v2.

Right, so I've updated the patches, and added one ack to one patch.
That seems insufficient to me - the only platform these have been
tested on is iMX6, which is sdhci-esdhc-imx.c.

They _really_ need testing elsewhere too.  Or is the plan to merge
them and then see about getting people to test them and fix them up
afterwards?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
