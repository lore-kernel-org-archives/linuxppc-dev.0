Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF66BDDF84
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:48:52 +1100 (EST)
Subject: Re: [PATCH 9/14] ps3: add interrupt alloc for outlets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0701251433330.31896@pademelon.sonytel.be>
References: <45B8188E.7020602@am.sony.com>
	<1169697334.24996.54.camel@localhost.localdomain>
	<Pine.LNX.4.62.0701251433330.31896@pademelon.sonytel.be>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 13:48:36 +1100
Message-Id: <1169779716.24996.90.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Do you have a preference which names to keep?
> 
>  1. ps3_connect_irq() and ps3_disconnect_irq() resemble the LV1 calls they
>     make,
>  2. ps3_alloc_irq() and ps3_free_irq() resemble the other
>     ps3_{alloc,free}_*_irq() names.
> 
> Personally I favor the latter.

Well, I think connect is a better illustration of the semantic. They
don't only alloc/free, since also connect. I think alloc/free is
actually confusing. Or maybe ps3_alloc_and_connect_irq() :-)

Ben.
