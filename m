Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CF053B72B6
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2012 11:27:30 +1000 (EST)
Message-ID: <1339982830.2372.8.camel@pasglop>
Subject: Re: [PATCH 01/15] i2c/powermac: Register i2c devices from device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Mon, 18 Jun 2012 11:27:10 +1000
In-Reply-To: <1339312981.24838.98.camel@pasglop>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <1334823416-9138-2-git-send-email-benh__33169.052625499$1334826821$gmane$org@kernel.crashing.org>
 <m2r4tofuxr.fsf@igel.home> <1339279889.24838.93.camel@pasglop>
 <m2k3zgf79j.fsf@igel.home> <1339281364.24838.94.camel@pasglop>
 <m2fwa4f5x5.fsf@igel.home> <1339283422.24838.96.camel@pasglop>
 <m2zk8br65n.fsf@linux-m68k.org> <1339312981.24838.98.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-06-10 at 17:23 +1000, Benjamin Herrenschmidt wrote:

> Ah, excellent, so a small quirk in i2c_powermac is the way to go then,
> we can detect it by name and hack up something. Either that or even
> better, in prom_init, we could add the missing property to the
> device-tree.
> 
> Any chance you can try that ? (Look at other examples of DT fixups in
> prom_init.c and don't forget the RELOC() around strings :-)

Ok, don't bother. I've been looking into it more closely and I think
the best solution here is actually self contained in i2c-powermac.

I found a couple more device-tree oddities in older machines that
I'm adding workarounds for as well. I'll send a couple of patches
later today including your original one.

Cheers,
Ben.
