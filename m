Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 346FADE2B5
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 14:16:40 +1000 (EST)
Subject: Re: [RFC/PATCH 4/4] Simplify xics direct/lpar irq_host setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <e16ca5457060787c0d339e1b707e75c6f875f7b6.1207032121.git.michael@ellerman.id.au>
References: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
	<e16ca5457060787c0d339e1b707e75c6f875f7b6.1207032121.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 14:16:31 +1000
Message-Id: <1208492191.6958.392.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-04-01 at 17:42 +1100, Michael Ellerman wrote:
> The xics code currently has a direct and lpar variant of xics_host_map, the
> only difference being which irq_chip they use. If we remember which irq_chip
> we're using we can combine these two routines. That also allows us to have a
> single irq_host_ops instead of two.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
