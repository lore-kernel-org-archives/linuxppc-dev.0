Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6841DDE1F
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:17:15 +1100 (EST)
Subject: Re: [PATCH 18/21] [POWERPC] bamboo: remove bogus "ranges" property
	in EBC node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071221060921.4ae5bc20@zod.rchland.ibm.com>
References: <20071221043939.72A8BDDFCF@ozlabs.org>
	<20071221060921.4ae5bc20@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 22 Dec 2007 08:16:55 +1100
Message-Id: <1198271815.6737.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-12-21 at 06:09 -0600, Josh Boyer wrote:
> On Fri, 21 Dec 2007 15:39:35 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > This removes a bogus empty "ranges" property in the EBC device node
> > of the Bamboo board device-tree.
> > 
> > The "ranges" property will be created by the boot wrapper, there is
> > no need to have an empty property there, and that causes recent
> > dtc to complain.
> 
> The wrapper doesn't do anything with EBC for bamboo because the EBC
> stuff is a nightmare on this board.  The patch can stand, but I'll
> fixup the comments in the changelog.

The wrapper could still create ranges for the chip select settings no ?

In any case, empty "ranges" is bogus.

Ben.
