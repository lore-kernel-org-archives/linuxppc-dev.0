Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95A5DDDEB8
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 18:02:06 +1000 (EST)
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070513061954.GA16623@lixom.net>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
	<20070513005830.38ba8e3b@the-village.bc.nu>
	<200705130248.22844.arnd@arndb.de>
	<1179022810.32247.54.camel@localhost.localdomain>
	<20070513061954.GA16623@lixom.net>
Content-Type: text/plain
Date: Sun, 13 May 2007 18:01:50 +1000
Message-Id: <1179043310.32247.58.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Great. That should fit perfectly with the glue I have now, it'll turn
> into the constructor instead.
> 
> I honestly don't see what the benefit is of this recent obsession
> with creating of_platform devices for every new device that's not
> PCI, especially when there's an already well-fitting driver in the
> traditional platform model. It's not like the code to link the two is
> large and complex.

I agree.

> Also, in this particular case, the bindings are not standardized, and
> there's a good chance that whatever new platform uses a similar device
> will need to do something slightly different.

Yup.

Ben.
