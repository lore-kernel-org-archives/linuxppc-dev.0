Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B53AC1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 06:59:34 +1100 (AEDT)
Date: Thu, 15 Oct 2015 12:53:16 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: Re: [PATCH v3 3/5] clk: qoriq: Add ls2080a support.
Message-ID: <20151015195316.GS4558@codeaurora.org>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
 <1442723397-26329-4-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442723397-26329-4-git-send-email-scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/19, Scott Wood wrote:
> LS2080A is the first implementation of the chassis 3 clockgen, which
> has a different register layout than previous chips.  It is also little
> endian, unlike previous chips.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
