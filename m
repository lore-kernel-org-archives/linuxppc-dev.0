Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1DC5DDED4
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 07:44:04 +1100 (EST)
Subject: Re: [PATCH 11/20] [POWERPC] Wire up PCI on Bamboo board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <476ACFD8.1000506@ru.mvista.com>
References: <20071213073845.1D311DE053@ozlabs.org>
	<47691DE6.8050901@ru.mvista.com> <1198095967.18908.33.camel@pasglop>
	<476ACFD8.1000506@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 21 Dec 2007 07:43:36 +1100
Message-Id: <1198183416.6779.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-20 at 23:26 +0300, Valentine Barshak wrote:

> Just checked the ppc440ep user manual again.
> Special cycle/IACK registers are at 0xeed00000 instead of 0xeed80000.
> Looks like the same typo as in the internal registers.
> It works because all these registers are mirrored at 0x80000 offset 
> (though it's claimed to be a reserved region).

Well, as for IACK, it also probably works because nobody uses it :-) I
put it in the device-tree for completeness (and in case somebody ever
uses it) but so far, nobody does and there is no proper interface to
expose it in linux.

Ben.
