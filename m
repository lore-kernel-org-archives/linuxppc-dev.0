Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 784681007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 06:22:19 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Handling multiple GPIO controllers in 8xxx GPIO driver
Date: Thu, 29 Sep 2011 20:22:06 +0000
Message-ID: <4E84D36D.3050200@freescale.com>
References: <4E81D6C0.3010201@embedded-sol.com>
	<20110927182912.GA3994@ponder.secretlab.ca>
	<CAOZdJXW7uSSMO2KP7gW9UVQXNvBiYJoDRWsJWtPGXgWY-PXvCQ@mail.gmail.com>
	<20110929172737.GF6800@ponder.secretlab.ca>
In-Reply-To: <20110929172737.GF6800@ponder.secretlab.ca>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> A chained handler has an expedited path through the interrupt code for
> handling it (basically, it skips handling it at the parent controller
> and passes through to the child, but it cannot handle multiple chained
> children on a single irq input.

So you can't do a shared chained handler?  If the chained handler returns=20
IRQ_NONE, the interrupt code just gives up?

Why is it called a "chained" handler?  Where's the chain?

I'm trying to understand the core interrupt code, and I can't seem to find=
=20
any descriptions of it.

--=20
Timur Tabi
Linux kernel developer at Freescale=
