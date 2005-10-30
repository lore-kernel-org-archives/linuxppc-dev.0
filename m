Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD9D468660
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 08:43:15 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20051030213517.GA11327@pb15.lixom.net>
References: <1130645036.29054.229.camel@gaston>
	<20051030175956.GB7039@pb15.lixom.net>
	<1130706859.29054.283.camel@gaston>
	<20051030213517.GA11327@pb15.lixom.net>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 08:41:54 +1100
Message-Id: <1130708514.29054.292.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, bcm43xx-dev@lists.berlios.de
Subject: Re: 30 bits DMA and ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The non-iommu case might want to do that for other devices as well,
> i.e. 32-bit limited ones on 64-bit machines.

Yup, that would be useful with some 3rd party bridges that don't have an
iommu ... :)

> Yep, the table is already split once, and I'm not sure in retrospect how
> useful that split was anyway, it can maybe go away. Switching it around
> shouldn't be a big issue.

No real need to split permanently... the search could be restricted to a
given range easily.

Ben.
