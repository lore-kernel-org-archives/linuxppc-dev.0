Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E920DB7D5B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 22:42:51 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100521102255.GC24511@zod.rchland.ibm.com>
References: <1274433088.1931.63.camel@pasglop>
	<20100521102255.GC24511@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 May 2010 22:42:34 +1000
Message-ID: <1274445754.1931.65.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-05-21 at 06:22 -0400, Josh Boyer wrote:
> On Fri, May 21, 2010 at 07:11:28PM +1000, Benjamin Herrenschmidt wrote:
> >Hi Linus !
> >
> >Here's the powerpc batch for this merge window.
> >
> >Most of it is in arch/powerpc, a few powerpc specific drivers are hit
> >too, including removing one that has been unused (and unselectable in
> >Kconfig) for a long time (hdpuftrs), probably remains of a long dead
> >platform.
> 
> You missed my updated pull request.  I still have some patches sitting in my
> -next branch that should go in.

Allright, I'll add them asap. Might have to wait for monday tho.

Cheers,
Ben.
