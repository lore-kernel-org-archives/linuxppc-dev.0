Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6F25DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 20:27:05 +1100 (EST)
Subject: Re: [PATCH 12/24] powerpc: 4xx PLB to PCI Express support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0472C239-D0C8-43FE-9996-1C28584EFBAD@kernel.crashing.org>
References: <20071130061155.41D71DDF5F@ozlabs.org>
	<0472C239-D0C8-43FE-9996-1C28584EFBAD@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 20:26:51 +1100
Message-Id: <1196414811.13230.88.camel@pasglop>
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


> Is it intentional that you dont support ppc_md.pci_exclude_device()?

More like I didn't have a need for it... that can easily be fixed when
it arises.

Cheers,
Ben.
