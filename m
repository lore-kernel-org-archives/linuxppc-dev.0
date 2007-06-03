Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F138BDDDF3
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 00:50:58 +1000 (EST)
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts
	file.
In-Reply-To: Your message of "Sun, 03 Jun 2007 10:33:39 +0200."
	<20070603083339.GB2157@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
Date: Sun, 03 Jun 2007 09:50:49 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HurPt-0002EP-It@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Gabriel Paubert mumbled:
> 
> This said, I'm looking at device trees right now, and I can understand
> that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
> I don't understand at all why it is &pci1 on the mpc85??cds.dts.
> 
> But the definition of the ISA bridge in these files is very strange to 
> start with: I've never seen an ISA bridge with only an interrupt controller 
> on it, no interrupts are connected to it and its reg property is
> almost certainly wrong. Maybe it is an example of things that should
> not be done.

I think this is an example of Early Days Misunderstanding Creep.
It was likely one of the very first attempts to write the file for
any FSL embedded part, and as such, it was probably not so good.

Likely, it could use some cleanup.  Patches and suggestions welcome.

jdl
