Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A178FDDDF3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 09:14:38 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n44NEMdU025798
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 16:14:33 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n44NEM0m012425
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 18:14:22 -0500 (CDT)
Date: Mon, 4 May 2009 18:14:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 00/13] OF device tree handling of PHY drivers
Message-ID: <20090504231421.GA27541@ld0162-tx32.am.freescale.net>
References: <20090425224458.32392.31296.stgit@localhost.localdomain>
	<20090427.025436.68188155.davem@davemloft.net>
	<fa686aa40904271017x726f92ffsbbc730770298766b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40904271017x726f92ffsbbc730770298766b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, afleming@freescale.com,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 11:17:08AM -0600, Grant Likely wrote:
> Kumar,
> 
> David has pulled my phylib changes into his -next tree.  However, some
> of the driver changes have been compile tested only due to lack of
> hardware.  Who can I ask to test the changes to the following files?
> 
>  arch/powerpc/platforms/82xx/ep8248e.c     |    9 +-

Tested OK.

>  drivers/net/fs_enet/fs_enet-main.c        |   69 +--
>  drivers/net/fs_enet/mii-bitbang.c         |   29 +-

Tested OK on pq2fads.

>  drivers/net/fs_enet/mii-fec.c             |   26 +-

Tested on ep88xc.  No *new* problems. :-P

-Scott
