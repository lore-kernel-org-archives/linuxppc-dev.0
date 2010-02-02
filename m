Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 392E7B7D54
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 18:38:36 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add DMA mask to MPSC serial and network and
	UART device to serial
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Corey Minyard <minyard@acm.org>
In-Reply-To: <4B6716D8.2050209@acm.org>
References: <20100130000407.GA16156@minyard.local>
	<1265000313.8287.25.camel@pasglop>  <4B6716D8.2050209@acm.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Feb 2010 18:38:15 +1100
Message-ID: <1265096295.8287.104.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-02-01 at 12:00 -0600, Corey Minyard wrote:
> That's done in ppc_dflt_bus_notify(), but that didn't seem an
> appropriate
> place to do this.  If it is, it's easy enough to add it there, but
> that would mean it would get set for all devices on any type of ppc
> system.

Well, we are looking at setting up a sane default here. It can always be
overriden if necessary.

Cheers,
Ben.
