Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCtRj4VGZzDqF5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 19:25:05 +1000 (AEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rCtRj17dnz9sBm
 for <linuxppc-dev@ozlabs.org>; Mon, 23 May 2016 19:25:05 +1000 (AEST)
Date: Mon, 23 May 2016 11:24:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Message-ID: <20160523092451.GF15728@worktop.ger.corp.intel.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
 <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
 <20160522103912.GN3193@twins.programming.kicks-ass.net>
 <20160522204252.GH15383@graphite.smuckle.net>
 <20160523090004.GA21186@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523090004.GA21186@red-moon>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2016 at 10:00:04AM +0100, Lorenzo Pieralisi wrote:
> It is also related to static leakage power that depends on the operating
> voltage (ie higher operating frequencies require higher voltage) so in a
> way scaling frequency before going idle may not be effective if voltage
> does not scale too in turn.

Sure, but the platform drivers 'know' all this and can make the right
decision.
