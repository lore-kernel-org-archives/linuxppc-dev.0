Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A909DE108
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 21:24:57 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9EARPGj006319
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 06:27:25 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9EAOW6U260202
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 06:24:32 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9EAOWdD029591
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 06:24:32 -0400
Date: Tue, 14 Oct 2008 06:24:29 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH V2 4/4] POWERPC: Merge 32 and 64-bit dma code
Message-ID: <20081014062429.48abfb43@zod.rchland.ibm.com>
In-Reply-To: <9EE82BA3-5B0C-43BB-90B4-2A93999285C1@kernel.crashing.org>
References: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
	<20081013144904.GB18363@yoda.jdub.homelinux.org>
	<20081013154127.GA27124@yoda.jdub.homelinux.org>
	<209E575D-DDE2-406A-82DE-2DD445046C02@kernel.crashing.org>
	<20081013142100.7efc2c81@zod.rchland.ibm.com>
	<AF818ED4-F261-4EF8-A4CB-CA06FCA9386D@kernel.crashing.org>
	<1223940659.8157.288.camel@pasglop>
	<9EE82BA3-5B0C-43BB-90B4-2A93999285C1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Oct 2008 20:52:25 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Oct 13, 2008, at 6:30 PM, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2008-10-13 at 13:22 -0500, Kumar Gala wrote:
> >>> I don't think it matters much when it gets fixed, pre or post -rc1.
> >>> But
> >>> it should probably get fixed.  My hack was to pull isa_bridge_pcidev
> >>> into pci-common.c and export it from there.  The 64-bit PCI code can
> >>> initialized it, and the 32-bit can leave it NULL.  But I have no  
> >>> idea
> >>> if that is sane.  If so, I can probably submit a patch for it.
> >>
> >> I was just joking around about our "new" regression policy..  
> >> anyways I
> >> hope ben or maybe anton can comment about the ISA code.
> >
> > My policy for that sort of bug is fix ASAP. I'll give it a go when I  
> > do
> > my test builds. Funny I didn't catch it, I might be lacking a chrp32
> > defconfig in my build tests :-)
> 
> I pointed out to Stephen that kisskb.ellerman.id.au hasn't been  
> updating.. there is a chrp32 defconfig in there that would normally  
> catch something like this.

Except if kissb catches it, it's already committed in tree.  Better
than nothing, but it would be nice if people did a buildall before they
commit.

josh
