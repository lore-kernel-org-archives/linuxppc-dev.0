Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F40F02C0408
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 02:10:57 +1100 (EST)
Date: Mon, 2 Dec 2013 16:10:50 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 08/17] spi: mpc512x: adjust to OF based clock lookup
Message-ID: <20131202151050.GU2982@book.gsilab.sittig.org>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-9-git-send-email-gsi@denx.de>
 <20131202095034.GB12952@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131202095034.GB12952@e106331-lin.cambridge.arm.com>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 02, 2013 at 09:50 +0000, Mark Rutland wrote:
> 
> On Sat, Nov 30, 2013 at 10:51:28PM +0000, Gerhard Sittig wrote:
> > after device tree based clock lookup became available, the peripheral
> > driver need no longer construct clock names which include the PSC index,
> > remove the "psc%d_mclk" template and unconditionally use 'mclk'
> > 
> > acquire and release the 'ipg' clock item for register access as well
> 
> For this and the other peripheral updates, it would be nice to have the
> expected clock-names entries added to the respective binding documents.
> Otherwise this looks fine to me.

I will look into adding these 'clock-names' to binding documents
for the peripherals, too (not just SPI but the others as well).
Thank you for the feedback!

It appears that not all of those peripherals have existing
binding docs, so introducing these docs in the first place may
exceed the scope of the CCF support introduction series, and I
may have to create another series for the doc updates.  I assume
that it's OK to address the issue of missing documentation in a
separate action.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
