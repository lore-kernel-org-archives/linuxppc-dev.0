Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AC7C67B22
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 07:17:31 +1000 (EST)
Subject: Re: Linux v2.6.18-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1152542413.27368.131.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<pan.2006.07.07.15.41.35.528827@us.ibm.com>
	<1152441242.4128.33.camel@localhost.localdomain>
	<1152537672.28828.4.camel@farscape.rchland.ibm.com>
	<1152542413.27368.131.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 07:17:16 +1000
Message-Id: <1152566236.1576.100.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> That in repeat generally means the IRQ logic on the platform has been
> broken. If we don't get interrupts we don't work very well.
> 
> Also check if booting with "nodma" set on the relevant ide interface
> makes a difference. Just to be sure. If it does then submit patches to
> fix the bug.

it's most certainly an irq problem as I just rewrote the irq logic of
powerpc :) There have been some issues and I've just sent some new
patches fixing them, let's see if that's enough. I'll give a js20 a try
today at work.

Ben.
