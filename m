Return-Path: <SRS0+8f2be1f524bb961c24bd+1383+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84920DDE37
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 00:48:16 +1000 (EST)
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
From: David Woodhouse <dwmw2@infradead.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <46630256.8050909@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
	<4662E7EA.70506@ru.mvista.com>
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>
	<46630256.8050909@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 15:47:56 +0100
Message-Id: <1181227676.2785.47.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-06-03 at 22:03 +0400, Sergei Shtylyov wrote:
>     That's the way the cookie crumbles in Linux MTD for now. It's
> *always* detecting this by probing -- you only can say what [not] to
> probe.

You could hook it up to the chip drivers directly if you want, and
bypass the probe code. I'm not sure it's worth it.

-- 
dwmw2
