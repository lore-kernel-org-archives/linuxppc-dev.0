Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D5A2DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 17:20:22 +1100 (EST)
Subject: Re: [PATCH] Hide resources on Axon PCIE root complex nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <62a10dda33b8e6b790f13057daea1430ed81ef1c.1205907051.git.michael@ellerman.id.au>
References: <62a10dda33b8e6b790f13057daea1430ed81ef1c.1205907051.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Wed, 19 Mar 2008 17:19:46 +1100
Message-Id: <1205907586.26869.286.camel@pasglop>
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


On Wed, 2008-03-19 at 17:10 +1100, Michael Ellerman wrote:
> The PCI bridge representing the PCIE root complex on Axon, contains device
> BARs for a memory range and ROM that define inbound accesses. This confuses
> the kernel resource management code, the resources need to be hidden when
> Axon is a host bridge.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
