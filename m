Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6ADDEDDEBD
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 07:45:07 +1100 (EST)
In-Reply-To: <1167682254.23340.131.camel@localhost.localdomain>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<1167682254.23340.131.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <32106685eb2ecb2fb4adcf6e51f71482@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
Date: Mon, 1 Jan 2007 21:44:15 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm not sure you can switch it to native mode in sw... worth double
> checking though. All boards based on 8111 on powerpc have this problem,
> I think. What of the js20 and js21 with IBM firmware ?

At least with SLOF, we use native mode.

> Or does it have
> the ide strapped to native mode ?

It's not a strapping, it's a purely software thing -- see the PCIIDE
specification.

Lots of controllers get the interrupt thing wrong though -- but
AMD8111 isn't one of those.


Segher
