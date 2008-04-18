Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B605CDE297
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 14:15:42 +1000 (EST)
Subject: Re: [RFC/PATCH 3/4] Use pseries_setup_i8259_cascade() in
	pseries_mpic_init_IRQ()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <87206bccf429273c3d7abba408ef606b69bae265.1207032121.git.michael@ellerman.id.au>
References: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
	<87206bccf429273c3d7abba408ef606b69bae265.1207032121.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 14:15:31 +1000
Message-Id: <1208492131.6958.390.camel@pasglop>
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
> pseries_mpic_init_IRQ() implements the same logic as the xics code did to
> find the i8259 cascade irq. Now that we've pulled that logic out into
> pseries_setup_i8259_cascade() we can use it in the mpic code.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

(provided you test it and it works :-)

Ben.
