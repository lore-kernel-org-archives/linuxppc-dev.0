Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C24D2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 01:25:53 +1100 (EST)
Date: Mon, 2 Dec 2013 15:25:37 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 02/17] dts: mpc512x: introduce dt-bindings/clock/ header
Message-ID: <20131202142537.GS2982@book.gsilab.sittig.org>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-3-git-send-email-gsi@denx.de>
 <20131202094656.GA12952@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131202094656.GA12952@e106331-lin.cambridge.arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mike Turquette <mturquette@linaro.org>, Pawel Moll <Pawel.Moll@arm.com>,
 Detlev Zundel <dzu@denx.de>, Stephen Warren <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Scott Wood <scottwood@freescale.com>, Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Ian Campbell <ian.campbell@citrix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 02, 2013 at 09:46 +0000, Mark Rutland wrote:
> 
> On Sat, Nov 30, 2013 at 10:51:22PM +0000, Gerhard Sittig wrote:
> > introduce a dt-bindings/ header file for MPC512x clocks,
> > providing symbolic identifiers for those SoC clocks which
> > clients will reference from their device tree nodes
> 
> There should be a binding document update to go with this, pointing out
> that this include file defines the set of clock IDs for the MPC512x
> clocks.

It turns out the Freescale MPC512x did not have a separate clocks
binding document, but "just did the usual" and followed the
common bindings.

I've sent a separate doc update patch which becomes applicable
after the CCF implementation got accepted.

> Otherwise, this looks fine to me.

So I take this as a "reviewed by" of yours for this dt-bindings
header file patch, shall I have to re-submit the series.  Thanks!


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
