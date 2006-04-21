Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2040C679E2
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 07:51:18 +1000 (EST)
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brent Cook <bcook@bpointsys.com>
In-Reply-To: <200604210933.10888.bcook@bpointsys.com>
References: <20060420210201.GA25755@gate.ebshome.net>
	<20060420215514.GE25755@gate.ebshome.net>
	<1145594285.28014.12.camel@localhost.localdomain>
	<200604210933.10888.bcook@bpointsys.com>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 07:51:02 +1000
Message-Id: <1145656262.4090.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  not claiming to understand all of the issues here, but I have some 
> MV64460 / MPC7448-based systems, and they only boot if 
> CONFIG_NOT_COHERENT_CACHE=y

That is strange... Pegasos uses a Marvell bridge and it works with
coherent cache. Do you have some kernel patches in addition to what is
in mainstream to make CONFIG_NOT_COHERENT_CACHE work at all on
CONFIG_6xx ? At the moment, it doesn't do much ...

Ben.
