Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CFDBADDF21
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 23:30:16 +1000 (EST)
Message-ID: <48C7CC0F.9020003@ru.mvista.com>
Date: Wed, 10 Sep 2008 17:30:55 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: IDE
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>
	<319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
	<48C79BDE.6030905@ru.mvista.com> <200809101304.51990.arnd@arndb.de>
In-Reply-To: <200809101304.51990.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

>>   Most probably you can use the existing platform drivers: 
>>drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.
>>Create/register a platform device named "pata_platform" with 2 memory 
>>and 1 IRQ resource, and enable one of those drivers.

> For new boards using a flattened device tree, it should be enough
> to add a device node for the pata_of_platform driver.

    Oops, forgot about this one. No wonder, after being knee deep in ARM for 
several months. :-)

MBR, Sergei
