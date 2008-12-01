Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9178ADDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Dec 2008 08:04:47 +1100 (EST)
Subject: Re: Accessing PCI-E resources on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <4933C5AF.5040406@embedded-sol.com>
References: <490F6882.6050101@embedded-sol.com>
	<1228118085.7356.115.camel@pasglop> <4933C5AF.5040406@embedded-sol.com>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 08:04:12 +1100
Message-Id: <1228165452.7356.123.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-01 at 13:08 +0200, Felix Radensky wrote:
> and I'm afraid it can take me some time to move from 2.6.26 to 2.6.28.
> Any chance I can backport you modifications to 2.6.26 ? Have you
> modified
> other files except arch/powerpc/sysdev/ppc4xx_pci.c to fix these
> problems ?
> 

Yes, quite a few changes in the PCI layer etc...

Board support changes shouldn't be too hard to port over tho, it depends
how you did them.

Cheers,
Ben.
