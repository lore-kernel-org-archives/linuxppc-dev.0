Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90AFDDE6F6
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 22:52:39 +1000 (EST)
Subject: Re: linux-next: 4xx build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080416072453.59858204@zod.rchland.ibm.com>
References: <20080416194227.1e5e1a9a.sfr@canb.auug.org.au>
	<20080416072453.59858204@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Apr 2008 22:51:22 +1000
Message-Id: <1208350282.6958.285.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Grr.  Yes, that's probably the right solution for now.  I had forgotten
> about Axon.
> 
> Sorry for the trouble.  I'll revert those commits locally and repush.

MMIO is not only Axon.. .some Xilinx stuff too. We should have a proper
implementation of the dcri stuff for MMIO.

Ben.
