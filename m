Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1C50DDEE4
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 05:17:48 +1000 (EST)
Message-ID: <46A7A1D5.7020003@freescale.com>
Date: Wed, 25 Jul 2007 14:17:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<46A79DE0.8060405@ru.mvista.com> <46A79F14.9040409@freescale.com>
	<46A7A17C.8090505@ru.mvista.com>
In-Reply-To: <46A7A17C.8090505@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
>> It doesn't buy us anything in here, but it's conceivable that someone 
>> may want to write a driver that uses a shift in the I/O accessor 
>> rather than an array of port offsets,
> 
> 
>    It wouldn't be IDE driver then, and neither it would be libata which 
> also does this another way this (despite pata_platform uses shifts too 
> -- not in the accessors, so no speed loss).

The device tree is not just for Linux.

>> equivalent of the cntlzw innstruction, and shift makes it clear that 
>> the stride must be power-of-two).  Plus, using shift is consistent 
>> with what we do on ns16550.
> 
> 
>    Why the heck should we care about the UART code taling about IDE?!

Consistency?

>    So, let me consider your argument purely speculative and invalid. ;-)

Consider it whatever you want. :-)

-Scott
