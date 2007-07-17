Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18076.42297.26124.137770@cargo.ozlabs.ibm.com>
Date: Tue, 17 Jul 2007 21:17:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
In-Reply-To: <B2EA074C-5D8E-4E13-B6BF-E81FBA52E76E@kernel.crashing.org>
References: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
	<4694F608.2090503@freescale.com>
	<368E1200-1315-4C24-9876-C92CCF65EFE3@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3E42@zch01exm26.fsl.freescale.net>
	<1184260375.24515.35.camel@pterry-fc6.micromemory.com>
	<B2EA074C-5D8E-4E13-B6BF-E81FBA52E76E@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> The device tree describes _all_ hardware in the system,
> not just the things that are somewhat harder to probe
> for.

Actually, for embedded systems, the device tree is really only
required to describe the things that it's useful for the Linux kernel
to know.

The point of the device tree for embedded systems is to provide
configuration information, not to be able to claim compliance with
some set of legalistic requirements. :)

I think in some cases we have gone a little over the top in trying to
put everything in the device tree, in fact.  Ultimately I think it has
to be up to the more experienced embedded developers to say how much
detail in the device tree is actually helpful and how much is dead
weight.

Paul.
