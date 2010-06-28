Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F6ABB6EDD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 07:29:40 +1000 (EST)
Subject: Re: BUG: scheduling while atomic: swapper/0/0x00000002
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: paulmck@linux.vnet.ibm.com
In-Reply-To: <20100628164906.GA6667@linux.vnet.ibm.com>
References: <20100609215229.GA12774@linux.vnet.ibm.com>
	<1276125608.1962.0.camel@pasglop>
	<20100610010854.GA11432@linux.vnet.ibm.com>
	<20100628164906.GA6667@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Jun 2010 07:29:29 +1000
Message-ID: <1277760569.4200.190.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-06-28 at 09:49 -0700, Paul E. McKenney wrote:
> And it does appear to be reproducible perhaps 50% of boots running
> CONFIG_PREEMPT on kernel-ml8.  I have not yet seen it on any other
> system.
> Do you have a patch to instrument the interrupts so as to get the info
> you need, or should I improvise? 

ftrace & friends ?

I don't have anything existing in mind...

Cheers,
Ben.
