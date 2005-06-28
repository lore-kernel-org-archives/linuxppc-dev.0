Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8024D67B67
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 09:57:46 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <931dc22c9709211c29f2d9d504d8ff9e@kernel.crashing.org>
References: <1119847159.5133.106.camel@gaston>
	<931dc22c9709211c29f2d9d504d8ff9e@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 09:52:24 +1000
Message-Id: <1120002744.5133.212.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-06-28 at 09:43 +0200, Segher Boessenkool wrote:
> > This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> > split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> > powerbooks have, CONFIG_PM for power management related code, and just
> > left out of any CONFIG_* option for some generally useful stuff that 
> > can
> > be used on non-laptops as well.
> 
> Is there any real reason not to enable CONFIG_PM on all Macs

People using old desktop machines with little memory may want to keep
the RAM footprint low :)

Ben.
