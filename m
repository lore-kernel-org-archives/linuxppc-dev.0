Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA7C267A67
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 10:57:10 +1100 (EST)
Date: Wed, 1 Mar 2006 17:46:54 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Fastboot] Re: Kexec for booke PPC processors
In-Reply-To: <200603021012.57955.michael@ellerman.id.au>
Message-ID: <Pine.LNX.4.44.0603011746320.10931-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dagriego <dagriego@gmail.com>,
	fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, 2 Mar 2006 09:43, dagriego wrote:
> > I'm finishing my first pass on getting kexec to work on PPC booke
> > processor, and needed some insight into how to pass information from the
> > first kernel to the kexec'ed kernel.  This information is the board
> > information that the first kernel is given in r3 from the board firmware. 
> > Is there a standard convention for passing this information?
> 
> Yep, it's called the flat device tree.

Which PPC booke are you trying to get this to work on?

- kumar
