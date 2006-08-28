Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FA9767B5E
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 17:16:28 +1000 (EST)
In-Reply-To: <1156728139.8433.413.camel@localhost.localdomain>
References: <44EF818B.9080301@am.sony.com>
	<1156728139.8433.413.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <17A2B887-8653-4814-8E28-46C5E2192245@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc virq: new routine virq_to_hw
Date: Mon, 28 Aug 2006 09:16:06 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'd much prefer:
>
> static inline irq_hw_number_t virq_to_hw (unsigned int virq)
> {
> 	return irq_map[virq].hwirq;
> }
>
> I've grown to dislike the CR between the return type and the function
> name (I used to do that too) and it seems that this opinion is  
> shared by
> Linus (there was an old thread on lkml about it).

And while we're at it: no space before parenthesis in a function
declaration/definition.


Segher
