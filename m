Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DBEADDE1D
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 09:05:51 +1100 (EST)
Subject: Re: [PATCH 2/3] powerpc: Split mmu_context handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081204074653.0a8edf2d@zod.rchland.ibm.com>
References: <20081204054228.E8FE6DDE0F@ozlabs.org>
	<20081204074653.0a8edf2d@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 05 Dec 2008 09:03:38 +1100
Message-Id: <1228428218.10722.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-04 at 07:46 -0500, Josh Boyer wrote:
> ..but I couldn't let this one go.  Totally incorrect comments here given
> that the file is _for_ 8xx and 4xx. I suspect an errant copy/paste :).

Or rather blame "cp" :-) I just duplicated mmu_context_32.c and modified
both versions differently. Forgot that comment obviously, thanks.

Ben.
