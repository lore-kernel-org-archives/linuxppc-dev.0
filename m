Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from plan.enseirb.fr (plan.enseirb.fr [147.210.18.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B231DDF29
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 16:10:21 +1000 (EST)
Message-ID: <48C8B5F3.7050409@gmail.com>
Date: Thu, 11 Sep 2008 08:08:51 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: IDE
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>
	<319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
	<48C79BDE.6030905@ru.mvista.com> <200809101304.51990.arnd@arndb.de>
	<48C7CC0F.9020003@ru.mvista.com>
In-Reply-To: <48C7CC0F.9020003@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Where can I find a pata_of_platform node example ?

Sergei Shtylyov a écrit :
> Arnd Bergmann wrote:
>
>>>   Most probably you can use the existing platform drivers: 
>>> drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.
>>> Create/register a platform device named "pata_platform" with 2 
>>> memory and 1 IRQ resource, and enable one of those drivers.
>
>> For new boards using a flattened device tree, it should be enough
>> to add a device node for the pata_of_platform driver.
>
>    Oops, forgot about this one. No wonder, after being knee deep in 
> ARM for several months. :-)
>
> MBR, Sergei
>
