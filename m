Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7393DDDD05
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 07:32:33 +1000 (EST)
Subject: Re: [patch 02/10] powerpc: Move CONFIG_PPC64 into CPU selection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <d8ba058b9bc8f9738d2c3d764c568c1e@kernel.crashing.org>
References: <20070611232824.489103547@arndb.de>
	<20070611233353.734704855@arndb.de>
	<18030.15937.699275.958545@cargo.ozlabs.ibm.com>
	<200706121008.01661.arnd@arndb.de>
	<18030.32600.921348.218117@cargo.ozlabs.ibm.com>
	<d8ba058b9bc8f9738d2c3d764c568c1e@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 07:32:24 +1000
Message-Id: <1181683944.14818.268.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-06-12 at 13:35 +0200, Segher Boessenkool wrote:
> and/or allow a single kernel image to work on both 32-bit and
> 64-bit systems,  The current situation is far removed from that,
> so this patch is a bit premature in that aspect. 

Won't happen :-)

Ben.
