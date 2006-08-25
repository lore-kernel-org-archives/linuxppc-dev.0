Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1434967C5C
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 03:30:54 +1000 (EST)
In-Reply-To: <1156481183.8433.300.camel@localhost.localdomain>
References: <1156481183.8433.300.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2EC1B4EF-BD81-4579-91DF-05D52202865C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Make OF irq map code detect more error cases
Date: Fri, 25 Aug 2006 19:30:40 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Device-tree bugs on js20 with some versions of SLOF were causing the
> interrupt for IDE to not be parsed correctly and fail to boot. This
> patch adds a bit more sanity checking to the parser to detet some of
> those errors and fail instead of returning bogus informations. The
> powerpc PCI code can then trigger a fallback that works on those
> machines.

Quite similar to my patch you have been refusing, so I'll just

ACK

it, irrespective of if we need it or not (anymore) -- it's a good,
useful, cheap sanity check.  The patch looks good, too.


Segher
