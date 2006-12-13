Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A69667C5A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 09:16:45 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bob Brose <linuxppcdev@qbjnet.com>
In-Reply-To: <20061213190958.16479.qmail@kunk.qbjnet.com>
References: <20061213190958.16479.qmail@kunk.qbjnet.com>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 09:16:38 +1100
Message-Id: <1166048198.11914.210.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-13 at 19:09 +0000, Bob Brose wrote:
> I was hoping this might fix the irq mapping problem on the SuperMac 900
> detected as 16 (Unknown PowerSurge), no such luck. Though the mapping
> changed, the bottom 4 slots on the dec 21052 pci bridge still don't work
> with interrupt enabled devices.
> 
> As a rehash, there was no problem through 2.6.15 and it's been broken since.
> 
> A representative error message (2.6.19 with the fix irq routing patch):

Hrm... dang, though I had that right now. Let me double check your
device tree.

Looks like one of those cases where OF had it wrong because of the p2p
bridge and the old kernel worked around it with a trick that we must
have lost.

Ben.
