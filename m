Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 463B3B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 07:06:00 +1000 (EST)
Subject: Re: [PATCH] Stop pci_set_dma_mask() from failing when RAM doesn't
	exceed the mask anyway
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1249305244.15714.3.camel@macbook.infradead.org>
References: <1249069310.20192.220.camel@macbook.infradead.org>
	<1249079105.1509.95.camel@pasglop>
	<1249113285.20192.961.camel@macbook.infradead.org>
	<1249113656.1509.125.camel@pasglop>
	<1249117220.20192.1083.camel@macbook.infradead.org>
	<1249199437.12047.11.camel@pasglop>
	<1249305244.15714.3.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Tue, 04 Aug 2009 07:05:48 +1000
Message-Id: <1249333548.18245.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-03 at 14:14 +0100, David Woodhouse wrote:

> Do we care about that scenario? I think we might be able to "fix" it by
> setting the memory_limit when we allow pci_set_dma_mask() to succeed?
> That will effectively prevent the addition of memory that our crappy
> device can't reach, won't it?

We don't support hotplug memory on those machines anyway, do we ?

Cheers,
Ben.
