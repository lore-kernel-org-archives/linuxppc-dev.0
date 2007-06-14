Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19DC0DDF21
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 00:24:18 +1000 (EST)
In-Reply-To: <20070613045301.111A1DDEBB@ozlabs.org>
References: <20070613045301.111A1DDEBB@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f6de242ebc23302b198ed909fb131add@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 13/13] Fix problems with device tree representation of
	TSI-1xx bridges
Date: Thu, 14 Jun 2007 16:24:11 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The ethernet, i2c, bridge and PCI nodes were
> given only as "tsi-*" which is somewhat inprecise, we replace with
> "tsi108-*" in the case of Taiga (which has a TSI108 bridge), and
> "tsi109-*", "tsi108-*" in the case of Holly (which has a TSI109
> bridge).

To be sure -- are all those ts109 devices actually
compatible to their ancestors on tsi108?

Since I _have_ to complain about _something_ -- don't
you run a spellchecker on your commit messages?  :-)

Perfect patch as far as I can see, thank you David!

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
