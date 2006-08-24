Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45EAE67C5A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 17:58:31 +1000 (EST)
Subject: RE: [PATCH 1/3] Adapt ipic driver to new host_ops
	interface,addset_irq_type to set IRQ sense
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC344@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D0FC344@zch01exm20.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:58:17 +1000
Message-Id: <1156406297.8433.229.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Currently, it's difficult to get the irq type in host_map() before it is
> set in set_type().  Shall we add flow_type to the host_map() parameters?

I had that and decided to remove it for various reasons. host_map() can
set it to the default, it doesn't really matter if you end up with
multiple calls.

Ben.
