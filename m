Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E01B2DDE02
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 18:16:51 +1100 (EST)
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20071207010001.GA23575@kroah.com>
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop> <20071206063940.GA16474@kroah.com>
	<1196927934.7033.39.camel@pasglop> <20071207010001.GA23575@kroah.com>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 18:16:34 +1100
Message-Id: <1197184594.6572.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-06 at 17:00 -0800, Greg KH wrote:
> But that is how we already handle this today, in numerous places in
> the
> kernel for this very type.
> 
> So, you can disagree that this is what we need to do, and if so, feel
> free to fix up a whole lot of files in the tree :)

Heh, ok, allright, I'll respin with the casts.

Cheers,
Ben.
