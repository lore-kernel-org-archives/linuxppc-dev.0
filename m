Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8F7CDE6E2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 22:52:17 +1000 (EST)
Subject: Re: Please pull 'for-2.6.26' branch of 4xx tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080416073139.7f56e72c@zod.rchland.ibm.com>
References: <20080415102704.39511160@zod.rchland.ibm.com>
	<20080416072758.092c83c5@zod.rchland.ibm.com>
	<20080416073139.7f56e72c@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Apr 2008 22:50:47 +1000
Message-Id: <1208350247.6958.283.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-16 at 07:31 -0500, Josh Boyer wrote:
> On Wed, 16 Apr 2008 07:27:58 -0500
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > On Tue, 15 Apr 2008 10:27:04 -0500
> > Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > 
> > > Valentine Barshak (2):
> > >       [POWERPC] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
> > >       [POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround
> > 
> > These two commits have been dropped from the branch.  They cause the
> > allyesconfig build for powerpc to fail because CONFIG_PPC_DCR_MMIO
> > doesn't understand the dcri_clrset macro.
> 
> Crap.  Looks like you already pulled the tree.  We need to either
> revert those two commits, or essentially define dcri_clrset to a do {}
> while(0) in include/asm-powerpc/dcr-mmio.h so things build.

Why ? It should do the right thing, not nop ...

Ben.
