Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58D84DDF4A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 11:23:26 +1000 (EST)
In-Reply-To: <20070501173143.9d514ea4.sfr@canb.auug.org.au>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
	<20070501173143.9d514ea4.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5e7183d982a071c0e9dc7c7843caf6e7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 08/11] Begin to consolidate of_device.c
Date: Wed, 2 May 2007 03:23:19 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>,
	paulus@samba.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This moves all the common parts for the Sparc, Sparc64 and PowerPC
> of_device.c files into drivers/openfw/device.c.

s/openfw/of/

Cheers,


Segher
