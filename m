Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 814AEDDFC7
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:39:21 +1100 (EST)
Date: Wed, 12 Dec 2007 10:39:08 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071212163908.GA4329@loki.buserror.net>
References: <20071210204705.GA31263@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210204705.GA31263@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 11:47:05PM +0300, Anton Vorontsov wrote:
> 6. FSL UPM NAND driver:
> -----------------------
> It's using FSL UPM functions and GPIO API. It does not implement
> device tree partitions parsing. That issue is completely other
> matter, that is, I have to factor out parsing functions from
> physmap_of.c. This desires separate patch on top of the whole
> series. If anyone currently working on this, let me know.

I've got a patch coming for that.

-Scott
