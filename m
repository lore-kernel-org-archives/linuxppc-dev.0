Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FCDDDDEC2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Dec 2006 08:19:04 +1100 (EST)
Subject: Re: virt_to_bus and DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Manish Joshi <mjoshi_blr@yahoo.com>
In-Reply-To: <20061124171814.56700.qmail@web34715.mail.mud.yahoo.com>
References: <20061124171814.56700.qmail@web34715.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 08:18:55 +1100
Message-Id: <1166735935.6673.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org, Ilse Reyneke <reynekejunk@hotmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> 
> 
> Am I also correct in saying the "standard DMA API" (request_dma, 
> set_dma_addr etc) is NOT available on the 4xx?

The standard DMA mapping API is: dma_map_* and that's what you should be
using.

At one point, virt_to_bus() will be removed and use of __pa in drivers
is highly discouraged.

Ben.
