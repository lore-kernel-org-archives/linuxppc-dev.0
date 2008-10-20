Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 12874DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 10:25:08 +1100 (EST)
Subject: Re: [RFC PATCH 0/5] patches for a network-based hvc backend (s390)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
In-Reply-To: <20081014091247.433079967@linux.vnet.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 10:23:37 +1100
Message-Id: <1224545017.7654.188.camel@pasglop>
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-14 at 11:12 +0200, Hendrik Brueckner wrote:
> Hello,
> 
> I work on a network-based hvc console backend for s390 that allows
> to get "full-screen" terminal access to z/VM guest machines.
> The solution consists of a HVC backend that provides the terminal interface;
> and a tool to connect to the terminal via a z/VM specific communication
> protocol.

 .../...

Hi !

What's the status with that patch serie ? Is this 2.6.28 material ?
Alan, are you ok with those ? Hendrik, have there been any respin other
than v2 of patch 4/5 ?

I can merge it via powerpc but it's getting late in the merge window...

Cheers,
Ben.
