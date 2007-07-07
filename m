Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E79D0DE1AE
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 08:17:00 +1000 (EST)
In-Reply-To: <200707071952.44524.arnd@arndb.de>
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<1183827083.3066.64.camel@shinybook.infradead.org>
	<468FC849.20801@ru.mvista.com> <200707071952.44524.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <32C5C654-0537-4349-A0F8-0C1166DD5C5C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
Date: Sun, 8 Jul 2007 00:15:43 +0200
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

> No, you're right. http://playground.sun.com/1275/proposals/Closed/ 
> Accepted/384-it.txt
> actually mentions that the the name should be "i8250". It also  
> mentions
> that the compatible property should contain "pnpPNP,501" for  
> ns16450 and
> higher,

16550 and higher

> and "pnpPNP,500" for all serial ports starting from i8250.

Yup.


Segher
