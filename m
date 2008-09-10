Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 8A222DDEFB
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 21:05:20 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: IDE
Date: Wed, 10 Sep 2008 13:04:51 +0200
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>
	<319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
	<48C79BDE.6030905@ru.mvista.com>
In-Reply-To: <48C79BDE.6030905@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809101304.51990.arnd@arndb.de>
Cc: =?iso-8859-1?q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 10 September 2008, Sergei Shtylyov wrote:
> =A0 =A0Most probably you can use the existing platform drivers:=20
> drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.
> Create/register a platform device named "pata_platform" with 2 memory=20
> and 1 IRQ resource, and enable one of those drivers.

=46or new boards using a flattened device tree, it should be enough
to add a device node for the pata_of_platform driver.
If you need a device specific setup, you should add a new "compatible"
value in the tree and make the driver handle that in whatever
way you need.

	Arnd <><
