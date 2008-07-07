Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A2C2DDF66
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:04:14 +1000 (EST)
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080707100627.4be05488@zod.rchland.ibm.com>
References: <20080701043607.07484DDED7@ozlabs.org>
	<20080707100627.4be05488@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:03:00 +1000
Message-Id: <1215468180.8970.124.camel@pasglop>
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

On Mon, 2008-07-07 at 10:06 -0400, Josh Boyer wrote:

> The setup is an tftp'd kernel via U-Boot using cuImage, nfsroot
> filesystem.  Sequoia has an FPU, and CONFIG_PPC_FPU is set.
> 
> I reverted this patch and used the latest powerpc-next branch and it
> boots fine.
> 
> Seems something is wrong here still.  I suspect the DSI handler
> changes, but I have no proof and haven't debugged it yet.  Until we
> get it fixed, I don't feel overly comfortable putting it in the next
> branch.  Which board and setup did you test with?

mambo and another board I don't remember which one precisely.

I'll have a look.

Cheers,
Ben.
