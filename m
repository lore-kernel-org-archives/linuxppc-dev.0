Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9F94DDD0D
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 20:54:51 +1100 (EST)
Subject: Re: purpose of /chosen node (was RE: [PATCH] powerpc: delete
	boot-cpu and chosen nodes from all DTSfiles)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <9415c89211d2197807813b8311f3ebb1@kernel.crashing.org>
References: <11713852392294-git-send-email-timur@freescale.com>
	<20070214003119.GF11491@localhost.localdomain>
	<45D29BBA.7090401@freescale.com>
	<20070214052440.GB12609@localhost.localdomain>
	<45D31734.7030808@freescale.com>
	<20070214233348.GH16279@localhost.localdomain>
	<c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
	<9415c89211d2197807813b8311f3ebb1@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 20:54:37 +1100
Message-Id: <1171619678.5644.69.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-16 at 08:30 +0100, Segher Boessenkool wrote:
> > If the kernel needs a convenient place to keep a phandle to the
> > top level interrupt controller,
> 
> Well that's the first point: the kernel doesn't need this
> at all, it can derive this from the rest of the tree easy
> enough.

Not that easy. I beleive it's better to have it expressed explicitely.

> > how about just under root?
> 
> CHRP does this (in an extra-plus nasty way).
> 
> > (Or, we could make up a new node)
> 
> Duplicate node?  No way.  You can be flexible with adding
> extra properties, but every node should represent a (pseudo-)
> device, and every device in the system should be represented
> by exactly one node.
> 
> Or you could make the convention that /aliases/interrupt-controller
> points to the root interrupt controller, if you really
> think you want this.

That too.

Ben.
