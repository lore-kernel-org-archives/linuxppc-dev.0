Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CF39DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 17:24:21 +1100 (EST)
Subject: Re: Bamboo PCI interrupt issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080303213718.12291eee@zod.rchland.ibm.com>
References: <1204588953.7921.13.camel@basalt>
	<20080303213718.12291eee@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 17:18:21 +1100
Message-Id: <1204611501.21545.48.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-03 at 21:37 -0600, Josh Boyer wrote:
> I plugged in an old 3Com ethernet card tonight.  Slot 0.  It was
> assigned dev #4 IRQ 25.  Using the device tree as-is, I could see
> interrupts happening in /proc/interrupts but ethernet traffic failed.
> 
> Then I changed the sense level to 4 as you suggested, and my card hung
> hard on the first ethernet traffic.  I've no idea if we're dealing
> with
> a crappy card or a crappy driver but the device tree seems to be
> working ok.  If I can find a different card to test with I will.
> 
> Ben, do you have any input here?

Other than bamboo has the weirdest combination of FPGA/CPLD/DIP switches
that I could never figure out if PCI was clocked properly ?

That might just be the problem :-)

I do remember having issues now that we talk about it. Though not
specifically what they were.

Ben.
