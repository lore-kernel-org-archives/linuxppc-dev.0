Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DD53DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 23:35:31 +1000 (EST)
In-Reply-To: <20070516034850.GF19127@localhost.localdomain>
References: <20070516034850.GF19127@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <925a2decc22f322a3db01b0f48778f50@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Date: Wed, 16 May 2007 15:35:22 +0200
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

> This patch corrects a number of minor errors in the Ebony device tree:
> 	- Missing (given as 0) cache sizes are added to the CPU node
> 	- device_type properties are removed from nodes which don't
> have a reasonably well defined device_type binding.  This does require
> a very small code change to locate the busses to be probed for
> of_platform devices by 'compatible' instead of 'device_type'.
> 	- A node is added for the SRAM controller
> 	- The unit address of the small-flash node is adjusted to
> correctly reflect the reg property.
> 	- device_type values for the MAL and ZMII are updated to
> reflected more up-to-date versions of the binding.
> 	- An incorrect offset in the partition map for the large-flash
> node is corrected.
> 	- Some redundant values, already commented out are removed
> entirely.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
