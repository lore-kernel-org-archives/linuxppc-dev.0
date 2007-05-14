Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9454EDDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 23:26:26 +1000 (EST)
Received: from e5.ny.us.ibm.com ([192.168.1.105])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4ECPktl017729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:25:46 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4ECMZVM010349
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:22:35 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4ECMZRB532120
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:22:35 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4ECMYJ4012874
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:22:35 -0400
Subject: Re: Small fixes for the Ebony device tree
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070514045404.GP6517@localhost.localdomain>
References: <20070514045404.GP6517@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 14 May 2007 07:22:29 -0500
Message-Id: <1179145349.3420.0.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 14:54 +1000, David Gibson wrote:
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

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
