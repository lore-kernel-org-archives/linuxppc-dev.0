Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F007DDF34
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 17:44:34 +1000 (EST)
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1193125016.20274.4.camel@concordia>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017230449.GZ4891@austin.ibm.com>
	<1192670843.6681.10.camel@concordia>
	<20071018190939.GE29903@austin.ibm.com>
	<1193125016.20274.4.camel@concordia>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 17:40:26 +1000
Message-Id: <1193125226.6745.185.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So Ben suggested what we really want is two routines,
> of_get_pci_dev_node() and of_peek_pci_dev_node() - the former returning
> a refcounted copy and the latter allowing you to "peek" at the
> device_node as long as you own the pci_dev.
> 
> I'm not sure it's worth the churn really, so we should probably just
> document that pci_device_to_OF_node() is contrary, and any users that
> need a reference can take one explicitly.

Yeah, I pretty much made the same decision a couple of years ago which
is why it's still the way it is now :-)

Cheers,
Ben.
