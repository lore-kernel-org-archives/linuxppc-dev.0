Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DE95DDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:31:30 +1100 (EST)
Subject: Re: [PATCH V2 4/4] POWERPC: Merge 32 and 64-bit dma code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AF818ED4-F261-4EF8-A4CB-CA06FCA9386D@kernel.crashing.org>
References: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
	<20081013144904.GB18363@yoda.jdub.homelinux.org>
	<20081013154127.GA27124@yoda.jdub.homelinux.org>
	<209E575D-DDE2-406A-82DE-2DD445046C02@kernel.crashing.org>
	<20081013142100.7efc2c81@zod.rchland.ibm.com>
	<AF818ED4-F261-4EF8-A4CB-CA06FCA9386D@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 10:30:59 +1100
Message-Id: <1223940659.8157.288.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 13:22 -0500, Kumar Gala wrote:
> > I don't think it matters much when it gets fixed, pre or post -rc1.   
> > But
> > it should probably get fixed.  My hack was to pull isa_bridge_pcidev
> > into pci-common.c and export it from there.  The 64-bit PCI code can
> > initialized it, and the 32-bit can leave it NULL.  But I have no idea
> > if that is sane.  If so, I can probably submit a patch for it.
> 
> I was just joking around about our "new" regression policy.. anyways I  
> hope ben or maybe anton can comment about the ISA code.

My policy for that sort of bug is fix ASAP. I'll give it a go when I do
my test builds. Funny I didn't catch it, I might be lacking a chrp32
defconfig in my build tests :-)

Cheers,
Ben.
