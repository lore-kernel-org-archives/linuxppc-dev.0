Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D70A7679F5
	for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2005 08:09:28 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
In-Reply-To: <0007F077BB3476449151699150E8FEA20592DE@exchange.tsi-telsys.com>
References: <0007F077BB3476449151699150E8FEA20592DE@exchange.tsi-telsys.com>
Content-Type: text/plain
Date: Tue, 03 May 2005 08:07:24 +1000
Message-Id: <1115071644.6031.28.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Endian Issue?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-02 at 17:27 -0400, Sanjay Bajaj wrote:
> We have linux (lk2.4.27-pre3) running on PPC440GX processor. The processor is connected to the Local PCI bus and to our custom device on this PCI bus. When we perform the DMA (or for that matter do memcpy_fromio()) from PCI bus memory to processor local memory, the data in the processor local memory is flipped (4 bytes at a time). Has anyone confronted this issue? Any ideas...

Using your device own DMA capabilities ? could be your device beeing
bogus, or your PCI bus incorrectly wired ...

Ben.
