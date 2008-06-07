Return-Path: <SRS0+c25b18fbc1076e96b82a+1749+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A5F5DDE2A
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 18:01:47 +1000 (EST)
Subject: Re: [PATCH v2] [NAND] driver extension to support NAND on TQM85xx
	modules
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <4847A8DA.6010406@grandegger.com>
References: <4847A8DA.6010406@grandegger.com>
Content-Type: text/plain
Date: Sat, 07 Jun 2008 09:01:41 +0100
Message-Id: <1212825701.32207.403.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-05 at 10:50 +0200, Wolfgang Grandegger wrote:
> [NAND] driver extension to support NAND on TQM85xx modules
> 
> This patch extends the FSL UPM NAND driver from Anton Vorontsov to
> support NAND on the TQM85xx modules. Unfortunately, the hardware does
> not support the R/B pins of the NAND chip and therefore the specified
> maximum delay time must used. It therefore re-introduces the chip-delay
> property.
> 
> Note: this patch is based on various patches from  Anton Vorontsov posted
>       to this list:
> 
>       http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.

Do you also want me to apply that patch (on which this one depends)?
It says 'Signed-off-by: not yet' ...

You should probably comment on the removal of the OF_GPIO dependency. It
looks fine, since the relevant functions all get stubbed out and will do
the right thing, but it's worth a comment in the commit text.

-- 
dwmw2
