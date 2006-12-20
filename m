Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29C90DDFBF
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 21:52:41 +1100 (EST)
Subject: Re: Please pull powerpc.git 'merge' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17801.3873.941944.129198@cargo.ozlabs.ibm.com>
References: <17801.3873.941944.129198@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 21:52:23 +1100
Message-Id: <1166611943.5144.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Jens Osterkamp (1):
>       [POWERPC] cell: Enable spider workarounds on all PCI buses

That one isn't totally correct I think, but it can go in, it won't harm,
it's just that the PCIe busses on the spider chip might need a slightly
different workaround. I'll send a separate patch on top of this one to
fix it.

Ben.
