Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B12DDDEE4
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 23:05:36 +1100 (EST)
Subject: Re: [PATCH V2 4/4] POWERPC: Merge 32 and 64-bit dma code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081014062429.48abfb43@zod.rchland.ibm.com>
References: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
	<20081013144904.GB18363@yoda.jdub.homelinux.org>
	<20081013154127.GA27124@yoda.jdub.homelinux.org>
	<209E575D-DDE2-406A-82DE-2DD445046C02@kernel.crashing.org>
	<20081013142100.7efc2c81@zod.rchland.ibm.com>
	<AF818ED4-F261-4EF8-A4CB-CA06FCA9386D@kernel.crashing.org>
	<1223940659.8157.288.camel@pasglop>
	<9EE82BA3-5B0C-43BB-90B4-2A93999285C1@kernel.crashing.org>
	<20081014062429.48abfb43@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 23:05:21 +1100
Message-Id: <1223985921.8157.341.camel@pasglop>
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

On Tue, 2008-10-14 at 06:24 -0400, Josh Boyer wrote:
> > I pointed out to Stephen that kisskb.ellerman.id.au hasn't been  
> > updating.. there is a chrp32 defconfig in there that would
> normally  
> > catch something like this.
> 
> Except if kissb catches it, it's already committed in tree.  Better
> than nothing, but it would be nice if people did a buildall before
> they
> commit.

I have a script that builds a dozen of config's, it looks like it didn't
catch that one. I'm going to add a chrp32_defconfig to it. Mistakes
happen, hopefully we can at least make sure the common configs are well
tested.

Cheers,
Ben.
