Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 501A3DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 08:04:09 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add xmon function to dump 44x TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <4ccc68f867a65d70f5d1e3ee946de4d1@kernel.crashing.org>
References: <20071116072415.95082DDDF2@ozlabs.org>
	<4ccc68f867a65d70f5d1e3ee946de4d1@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 17 Nov 2007 08:03:53 +1100
Message-Id: <1195247033.28865.169.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-16 at 16:54 +0100, Segher Boessenkool wrote:
> > +#ifdef CONFIG_44x
> > +static void dump_tlb_44x(void);
> > +#endif
> 
> No need to #ifdef this...
> 
> > +#ifdef CONFIG_44x
> > +static void dump_tlb_44x(void)
> > +{
> 
> ...or this.

I don't want to require binutils to understand the 44x TLB ops

Ben.
