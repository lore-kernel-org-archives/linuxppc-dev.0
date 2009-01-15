Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 9F653DE301
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 23:58:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Date: Thu, 15 Jan 2009 13:58:33 +0100
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901131842.54688.arnd@arndb.de>
	<20090115001251.GA10745@ovro.caltech.edu>
In-Reply-To: <20090115001251.GA10745@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901151358.34250.arnd@arndb.de>
Cc: netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	shemminger@vyatta.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 January 2009, Ira Snyder wrote:

> The only problem with that is that you cannot route interrupts from the
> DMA controller over PCI with the PowerPC core running. Which makes it
> mostly useless for this case.

If the host supports MSI, you can simply program the DMA controller to
write the correct message to the inbound address of the MSI interrupt
controller!

All modern host systems should have MSI, as this is required by the
PCIe specification, but it still somewhat limits the choice of your
hosts.

	Arnd <><
