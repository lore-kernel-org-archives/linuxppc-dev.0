Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7DB7EDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:12:47 +1100 (EST)
Date: Tue, 13 Feb 2007 18:21:33 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c to
	use it
Message-ID: <20070214002133.GA4851@lixom.net>
References: <1171408247467-git-send-email-timur@freescale.com>
	<1171411219.20192.118.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171411219.20192.118.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 11:00:19AM +1100, Benjamin Herrenschmidt wrote:
> 
> > +	return get_property(np, "address", NULL);
> 
> Since there is so much room for confusion with "address", please at
> least do some basic sanity checking, like check that it's size is 6
> bytes and maybe that the multicast bit isn't set.

No need to reinvent the wheel, is_valid_ether_addr() is easy to use.

Might still want to check the property length though.


-Olof
