Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D22E67B55
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 20:48:51 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc: consolidate feature fixup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1160646965.16101.4.camel@localhost.localdomain>
References: <1160641793.4792.133.camel@localhost.localdomain>
	<1160646965.16101.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 20:48:40 +1000
Message-Id: <1160650121.4792.140.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >  void __init setup_system(void)
> >  {
> > +	extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
> > +	extern unsigned int __start___fw_ftr_fixup, __stop___fw_ftr_fixup;
> 
> 
> Every extern in a C file ... god kills a kitten! :)

Well... it's a bit special in this case.. just a reference to a section,
I'd rather keep it close to the only call site...

Ben.
