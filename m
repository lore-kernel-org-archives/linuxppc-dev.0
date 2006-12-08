Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9631B67B5F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 15:11:20 +1100 (EST)
Subject: Re: Worst case performance of up()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17784.52970.343161.782030@cargo.ozlabs.ibm.com>
References: <1164385262.11292.76.camel@localhost.localdomain>
	<1164401124.5653.86.camel@localhost.localdomain>
	<1164661336.11001.9.camel@localhost.localdomain>
	<1165055754.4380.15.camel@localhost.localdomain>
	<1165058151.22108.31.camel@localhost.localdomain>
	<1165060484.4380.18.camel@localhost.localdomain>
	<1165092773.22108.47.camel@localhost.localdomain>
	<1165239794.17906.14.camel@localhost.localdomain>
	<1165263946.29784.13.camel@localhost.localdomain>
	<1165356002.5469.16.camel@localhost.localdomain>
	<17784.52970.343161.782030@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 14:10:59 +1100
Message-Id: <1165547459.5027.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-12-08 at 13:33 +1100, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > Paul, do you reckon the best solution here is to clear ppc_md.power_save
> > when detecting an SMP powermac ? (Or the flush-on-lock property)
> 
> Yes, that sounds good.  It would let us get rid of the runtime cpu
> feature check in idle_6xx.c too.

We would have to do something about users flippin powersave_nap tho...

Ben.
