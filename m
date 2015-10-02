Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0140.outbound.protection.outlook.com [157.56.111.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E7731A007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 10:24:29 +1000 (AEST)
Message-ID: <1443745434.5336.184.camel@freescale.com>
Subject: Re: [RFC PATCH 0/8] clk: qoriq: Move chip-specific knowledge into
 driver
From: Scott Wood <scottwood@freescale.com>
To: Michael Turquette <mturquette@linaro.org>
CC: Tang Yuantian <Yuantian.Tang@freescale.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Liberman Igal-B31950 <Igal.Liberman@freescale.com>,
 Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>,
 <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>
Date: Thu, 1 Oct 2015 19:23:54 -0500
In-Reply-To: <20150811182535.31346.52965@quantum>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
 <20150811182535.31346.52965@quantum>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-11 at 11:25 -0700, Michael Turquette wrote:
> Hi Scott,
> 
> Quoting Scott Wood (2015-06-18 19:49:10)
> > The existing device tree bindings are error-prone and inflexible. 
> > Correct the mistake by moving the knowledge into the driver, which
> > has more flexibility in describing the quirks of each chip.  This leaves
> > the device tree to its proper role of identifying a programming interface
> > rather than describing its individual registers.
> 
> Sorry for not responding to this one sooner. Fell through the cracks.
> 
> All of the changes to drives/clk/clk-qoriq.c look great to me. I assume
> you need to keep all of these patches together and want to the take
> through the freescale tree? If so feel free to add,
> 
> Acked-by: Michael Turquette <mturquette@baylibre.com>

Is the ack still valid for the v3 patchset?

-Scott
