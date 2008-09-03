Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0F97DE007
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 07:04:36 +1000 (EST)
Message-ID: <48BEFBA2.3020009@freescale.com>
Date: Wed, 03 Sep 2008 16:03:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: =?UTF-8?B?U8OpYmFzdGllbiBDaHLDqXRpZW4=?=
	<sebastien.chretien.enseirb@gmail.com>
Subject: Re: irq
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
	<48BEA106.9090307@selcomgroup.com>
	<319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
	<6a6049b80809030905u561043ecr1438d20aebf5598d@mail.gmail.com>
	<48BEBD17.1030705@gmail.com>
	<20080903170815.GA10979@loki.buserror.net>
	<48BEFB5D.3040903@gmail.com>
In-Reply-To: <48BEFB5D.3040903@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: M B <super.firetwister@googlemail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sébastien Chrétien wrote:
> irq_of_parse_and_map is equivalent to ioremap in the MMU case ?

It's more analogous to of_iomap().

-Scott
