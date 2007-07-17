Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84C25DDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 01:12:37 +1000 (EST)
In-Reply-To: <1184680385.18501.51.camel@mark>
References: <469B33F9.2080604@windriver.com> <200707170302.07469.arnd@arndb.de>
	<1184647742.10499.34.camel@mark> <200707171406.03455.arnd@arndb.de>
	<1184680385.18501.51.camel@mark>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1AAA4B60-2C7D-4741-96D0-0FC97411BD38@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
Date: Tue, 17 Jul 2007 17:12:29 +0200
To: Mark Zhan <rongkai.zhan@windriver.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> but, the current situation is that: in all DTS files that are using  
> smc
> or scc as uart device, all device node definitions have the same
> "compatible" property -- "cpm_uart"
>
> So what I do here is just following the upstream source tree.

True enough.  OTOH, it doesn't help to continue supporting
the "bad old stuff", esp. if new extra workarounds are
needed for it.


Segher
