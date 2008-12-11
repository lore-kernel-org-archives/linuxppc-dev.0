Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5372BDDF1C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 22:08:10 +1100 (EST)
Subject: Re: [PATCH] Introduce ppc_pci_flags accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081210195313.4014ca85@zod.rchland.ibm.com>
References: <20081210191148.GA1769@yoda.jdub.homelinux.org>
	<1228952788.7999.0.camel@localhost>
	<20081210185446.13e33cb2@zod.rchland.ibm.com>
	<Pine.LNX.4.64.0812101613140.28806@t2.domain.actdsltmp>
	<20081210195313.4014ca85@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 11 Dec 2008 22:06:01 +1100
Message-Id: <1228993561.22413.166.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-10 at 19:53 -0500, Josh Boyer wrote:
> 
> That's fine too.  I think you can Michael can have a virtual
> arm-wrestling match to decide whether ppc_pci_has_flag or
> ppc_pci_flags_are_set wins ;)

I vote for _has_flag() :-)

I even wonder if we need the word "flag" in there at all, but then I'm
just being anal !

Cheers,
Ben.
