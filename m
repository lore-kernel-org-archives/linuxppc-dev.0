Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFBA067B56
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 05:55:12 +1000 (EST)
Subject: Re: new IRQ stuff : some details?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20060713220628.54c2912d@vitb.ru.mvista.com>
References: <20060713220628.54c2912d@vitb.ru.mvista.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 05:55:10 +1000
Message-Id: <1152820510.23037.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-07-13 at 22:06 +0400, Vitaly Bordug wrote:
> Hi Ben,
> 
> As your irq rewrite touched mainstream, I am wondering about some details/directions to move fw and 
> update the boards up to it. Currently, the irq numbers are messed (since the board has 2 Int controllers), and I am assuming some touch to devicetree is needed, but not sure what exactly.
> 
> 
> Sorry if it have been brought up somewhere... 

It certainly needs some documentation update... I'm travelling at the
moment, but soon. Discussion is welcome :)

Ben.
