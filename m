Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EB5C1DDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 08:46:18 +1100 (EST)
Date: Sun, 23 Nov 2008 22:46:11 +0100
From: Benjamin Krill <ben@codiert.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Add support for the nwp serial device
Message-ID: <20081123214611.GS24487@codiert.org>
References: <200811201501.24000.arnd@arndb.de>
	<20081121132244.e9e9fd74.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20081121132244.e9e9fd74.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Andrew Morton | 2008-11-21 13:22:44 [-0800]:

>(does a powerpc allmodconfig)
>
>drivers/serial/nwpserial.c:443: warning: data definition has no type or storage class
>drivers/serial/nwpserial.c:443: warning: type defaults to 'int' in declaration of 'console_initcall'
>drivers/serial/nwpserial.c:443: warning: parameter names (without types) in function declaration
>drivers/serial/nwpserial.c:400: warning: 'nwpserial_console_init' defined but not used
>
>The file fails to include linux/init.h.  It should do so, but that
>doesn't fix the above.
>
>Apparently it hasn't been tested as a kernel module...

Console support doesn't work when the driver is build as module, all
other serial drivers did this with a further configuration option. Will
send an updated patch which fixes this and the other issues.
