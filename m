Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 484ACDDE2F
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 02:16:54 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l1KFG5AF022277
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 10:16:05 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1KFGkVn058948
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:16:46 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1KFGiwg009570
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:16:45 -0700
Subject: Re: [0/14] Ebony support, 2nd spi
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200702201607.33249.arnd@arndb.de>
References: <20070220020837.GF17818@localhost.localdomain>
	<1171982767.24204.70.camel@zod.rchland.ibm.com>
	<1171983806.24204.79.camel@zod.rchland.ibm.com>
	<200702201607.33249.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 09:17:46 -0600
Message-Id: <1171984666.24204.90.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 16:07 +0100, Arnd Bergmann wrote:
> On Tuesday 20 February 2007 16:03, Josh Boyer wrote:
> > And the ebony dts also has the a bus type of "ibm,opb" as well.
> 
> We should really get a common name for these. I don't remember
> what the discussions were, but it seems we came up with different
> results for Axon and ppc4xx, which is very bad.

Yes, using common types would be a very good idea. There's no published
DTS for Axon so we have no idea what has been previously defined.

> Using type "ibm,opb" rather than just "opb" makes sense to me,
> but I don't know if we already have shipping systems that use
> "opb" here.

I would prefer "ibm,xxx" as well if it's possible.

> There is probably a similar problem with the nodes for "plb4",
> "plb5" and "ebc", as well as the "compatible" property of the
> serial port, which, as you noted earlier is "ns16550" on 
> ebony and "ns16750" on axon, although it is exactly the same
> macro.

Right, ebony is currently using "ibm,plb".  We haven't defined an EBC
node yet for 4xx.

josh
