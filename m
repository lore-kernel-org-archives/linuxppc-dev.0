Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 15D702C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2013 05:39:19 +1100 (EST)
Date: Sun, 24 Nov 2013 19:39:08 +0100
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v5 00/17] add COMMON_CLK support for PowerPC MPC512x
Message-ID: <20131124183908.GG2760@book.gsilab.sittig.org>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384729577-7336-1-git-send-email-gsi@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Detlev Zundel <dzu@denx.de>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 linux-mtd@lists.infradead.org, Jiri Slaby <jslaby@suse.cz>,
 linux-serial@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>,
 linux-can@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Scott Wood <scottwood@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-spi@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 18, 2013 at 00:06 +0100, Gerhard Sittig wrote:
> 
> the series is based on v3.12, but I'll rebase against v3.13-rc1
> (when available) or any other subtree upon request

Now that v3.13-rc1 is out, I noticed that the series no longer
applies cleanly (minor context changes and conflicts) and needs
minor adjustment.

Compilation of 4/17 requires <linux/of_address.h> which no longer
is included implicitly.

PPC_CLOCK removal in 7/17 should remove <asm/clk_interface.h> as
well after all references to this header file have gone.  (And
the context of the patch has changed.)

The context of 16/17 for DIU initialization has changed.

I'll wait for a few more days whether there is more feedback for
v5 (especially on the device tree backwards compat approach),
then will rebase and send out v6 of the series.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
