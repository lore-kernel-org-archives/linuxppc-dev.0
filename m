Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7A16DDEEB
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 17:11:44 +1000 (EST)
Subject: Re: BUG() in current git, __dma_alloc_coherent, Beige G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080616070359.300020@gmx.net>
References: <20080616014615.GA8960@nineveh.local>
	<1213591838.8129.123.camel@pasglop>  <20080616070359.300020@gmx.net>
Content-Type: text/plain
Date: Mon, 16 Jun 2008 17:11:27 +1000
Message-Id: <1213600287.8129.125.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I discovered this bug some time ago and reported it on the list.
> See here for more info:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056128.html
> Anyway I don't think your machine needs dma-noncoherent.

Kumar, do you have a fix for that ?

Cheers,
Ben.
