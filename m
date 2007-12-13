Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B124DDFBB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 08:37:44 +1100 (EST)
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071213151138.02db0cd8@weaponx>
References: <20071213073851.C321FDDFC9@ozlabs.org>
	<20071213130113.59342c40@weaponx> <1197578243.15741.150.camel@pasglop>
	<20071213144056.1a46b7a3@weaponx> <1197579177.15741.169.camel@pasglop>
	<20071213151138.02db0cd8@weaponx>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 08:37:26 +1100
Message-Id: <1197581846.15741.183.camel@pasglop>
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


On Thu, 2007-12-13 at 15:11 -0600, Josh Boyer wrote:
> Well, there is physical PCI hardware on the boards, yes.  But what if
> people have no intention of using it?  E.g. they have no devices, etc.
> Now we're requiring PCI support to be built into the kernel.
> 
> I'm just being pedantic about keeping embedded tiny.

Keeping your embedded design tiny (and thus your own BSP) is one thing,
but adding ifdef's all over the place so that somebody can tinify an
eval board, I'm less sure about this... but if you want, you can fixup
my patches.

Ben.
