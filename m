Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F179167CA6
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:48:05 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4560C23D.6080304@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<4560BDF5.400@ru.mvista.com>
	<1163968376.5826.110.camel@localhost.localdomain>
	<4560C121.30403@ru.mvista.com>  <4560C23D.6080304@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:48:09 +1100
Message-Id: <1163969289.5826.121.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>     Sorry, it's the same for x86 version of OpenPIC according to spec. I meant 
> the PPC implementation here.

Same OpenPIC.. it can deal with both INTACK cycles and reading from an
INTACK register. On some PPC's, we actually have logic in the bridge to
generate the INTACK cycle (which exist on PCI) though we only use that
with 8259's currently as it's not really more efficient than just
reading from the INTACK register of the OpenPIC.

Ben.
