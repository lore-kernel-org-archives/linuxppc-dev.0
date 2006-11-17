Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7AFF67BAC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:16:26 +1100 (EST)
Subject: Re: [RFC] Workaround for G4 CPU data corruption bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20061116084800.132070@gmx.net>
References: <20061116084800.132070@gmx.net>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 19:16:50 +1100
Message-Id: <1163751410.5826.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-16 at 09:48 +0100, Gerhard Pircher wrote:
> Hi,
> 
> I need to fix the CPU bug described here:
> http://ozlabs.org/pipermail/linuxppc-dev/2004-August/017440.html
> 
> The bug is worked around in Linux (since a long time) by enabling coherency (M bit) for all memory mappings. Unfortunately my AmigaOne crashes badly with this workaround (the system simply stops after setting up the PCI host controller). I'm afraid I don't know about any snoop control settings within the northbridge.
> 
> Thus the only workaround I can think of would be to disable the L2 cache prefetch logic. But would this workaround be accepted in the Linux source tree (only for one architecture) or does anybody know another workaround?

Not sure what the best approach is at this point. The platform probing
occurs after the CPU fixups on 32 bits, though I want to change that to
be more like 64 bits in the future, it's not yet done.

Ben.
