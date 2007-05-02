Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 058C0DDF12
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:18:01 +1000 (EST)
Message-ID: <46389D85.7000301@garzik.org>
Date: Wed, 02 May 2007 10:17:41 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Rename get_property to of_get_property: drivers/net
References: <20070427145508.9c5641a2.sfr@canb.auug.org.au>
	<4633689E.50900@garzik.org>
	<20070429114446.31f40a30.sfr@canb.auug.org.au>
	<20070428.204754.62343452.davem@davemloft.net>
	<3802D7AD-67EC-4FA2-B361-A388AFCB0B94@kernel.crashing.org>
In-Reply-To: <3802D7AD-67EC-4FA2-B361-A388AFCB0B94@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sfr@canb.auug.org.au, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, akpm@linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Apr 28, 2007, at 10:47 PM, David Miller wrote:
> 
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Sun, 29 Apr 2007 11:44:46 +1000
>>
>>> So can I take this as a future OK for architecture specific network
>>> drivers changes to go through the architecture trees (cc'd to you)?
>>
>> It's been my experience that if I'm just working through some
>> platform or bus specific API changes, people like Jeff tend to
>> not mind if it goes via ARCH trees and the like.
> 
> Is this acceptable?   Just want to make sure before I ask Paul to pull 
> some changes that touches the following drivers:
> 
> drivers/net/fs_enet/mac-scc.c           |    2 +-
> drivers/net/ucc_geth.c                  |   30 ++++----
> drivers/serial/cpm_uart/cpm_uart_cpm1.c |    4 +-
> drivers/serial/cpm_uart/cpm_uart_cpm2.c |    4 +-

I don't see a patch, just a diffstat.

	Jeff
