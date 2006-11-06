Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00F8C67C68
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 19:09:04 +1100 (EST)
Subject: Re: Can't build drivers/infiniband/hw/ipath/ipath_keys.c on
	arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1162798399.8175.24.camel@localhost.localdomain>
References: <1162798399.8175.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 19:06:48 +1100
Message-Id: <1162800409.28571.298.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: support@pathscale.com, Andrew Morton <akpm@osdl.org>,
	openib-general <openib-general@openib.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 18:33 +1100, Michael Ellerman wrote:
> Hi,
> 
> Just a heads-up, drivers/infiniband/hw/ipath/ipath_keys.c doesn't build
> on powerpc because we have don't have bus_to_virt().
> 
> (Actually you can't select CONFIG_INFINIBAND_IPATH on mainline because
> powerpc doesn't enable PCI_MSI, but we will real soon now, and when we
> do this will start breaking people's all modconfig builds).

I'm surprised that something as recent as infiniband requires a
long-deprecated function bus_to_virt().

What is it trying to do there that needs that call ?

Ben.
