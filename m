Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC586DE021
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:46:21 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4UDkIqR003047
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 09:46:18 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4UDkGSi220262
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:46:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4UDkFsU014309
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:46:15 -0600
Subject: Re: Fix problems with device tree representation of TSI-1xx bridges
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070530013718.GB21955@localhost.localdomain>
References: <20070530013718.GB21955@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 30 May 2007 08:44:00 -0500
Message-Id: <1180532640.3360.74.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 11:37 +1000, David Gibson wrote:
> This patch fixes some problems with the way the some things
> represented in the device tree for the Holly and Taiga boards.  This
> means changes both to the dts files, and to the code which
> instantiates the tsi108 ethernet platform devices based on the device
> tree.

Looks great.  Thanks for the cleanups David.  I had some of these on my
list as well.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
