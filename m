Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E291ADDE0A
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 07:08:40 +1000 (EST)
Subject: Re: why does ppc64 require boards to call pci_devs_phb_init()?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <33403DE1-6AC2-49E9-9539-C520E4944D77@kernel.crashing.org>
References: <33403DE1-6AC2-49E9-9539-C520E4944D77@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 01 May 2009 07:08:30 +1000
Message-Id: <1241125710.29501.35.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-30 at 10:37 -0500, Kumar Gala wrote:
> looking at merging this in w/ppc32 and wondering why board code has to  
> call pci_devs_phb_init() and not do it via pcibios_init()

As I said on IRC, not too sure at the moment, it could be due to some
ordering issues where pSeries needs the pci_dn's to be there before
pcibios_init(). We'll have to dig a bit on that one.

Cheers,
Ben.
