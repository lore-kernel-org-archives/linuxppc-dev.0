Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DAC03DDF27
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 08:44:43 +1100 (EST)
Subject: Re: [BUG] 2.6.28-git12: "powerpc/pci: Reserve legacy regions on
	PCI" broke my G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@it.uu.se>
In-Reply-To: <200901172246.n0HMkvrv004832@harpo.it.uu.se>
References: <200901172246.n0HMkvrv004832@harpo.it.uu.se>
Content-Type: text/plain
Date: Mon, 19 Jan 2009 08:44:20 +1100
Message-Id: <1232315060.23611.44.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-01-17 at 23:46 +0100, Mikael Pettersson wrote:
> The 2.6.29-rc kernels hang during boot on my PowerMac G3 (Beige).
> The last messages I see on the console are
> 
> Kernel command line: ramdisk_size=8192
> irq: Found primary Apple PIC /pci/mac-io for 64 irqs
> irq: System has 64 possible interrupts
> 
> and then it hangs until I reboot it. Unfortunately I don't have a serial cable
> compatible with the G3's serial port so I can't set up a serial console.
> 
> Eventually I narrowed the cause down to "powerpc/pci: Reserve legacy regions on PCI"
> (commit c1f343028d35ba4e88cd4a3c44e0d8b8a84264ee) in 2.6.28-git12. Reverting that
> from 2.6.29-rc2 results in a kernel that boots ok and works reliably.
> 
> The problem seems system specific as both my G5 and my G4 had no problems at all
> with 2.6.29-rc1.

Thanks, I'll try to narrow it down, but it will take a week or so as I'm
away attending LCA. I think I have one of these Beige G3's in the office
somewhere....

Cheers,
Ben.
