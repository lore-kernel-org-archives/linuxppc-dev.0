Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED648DE212
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 08:24:23 +1000 (EST)
In-Reply-To: <200707071410.14998.arnd@arndb.de>
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<200707071410.14998.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B93D7000-4F4B-44B9-B065-3C6F233A14BE@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
Date: Sun, 8 Jul 2007 00:23:06 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The MV64660 has reg-shift==2 for its otherwise 16550-compatible  
>> uarts.
>> While the bootwrapper copes with this, of_serial.c doesn't. (The udbg
>> code doesn't either, but I'll fix that later).
>>
>> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

So let me just say NAK so this doesn't accidentally get
applied :-)


Segher
