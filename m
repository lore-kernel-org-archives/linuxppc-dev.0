Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C0B402C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 13:41:03 +1000 (EST)
Message-ID: <1367206844.7288.0.camel@pasglop>
Subject: Re: linux-next: manual merge of the vfs tree with the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 29 Apr 2013 13:40:44 +1000
In-Reply-To: <20130429113540.55b2593d303bc2a9142919fc@canb.auug.org.au>
References: <20130429113540.55b2593d303bc2a9142919fc@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-next@vger.kernel.org,
 Al Viro <viro@ZenIV.linux.org.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-04-29 at 11:35 +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the vfs tree got a conflict in
> arch/powerpc/kernel/rtas_flash.c between commit ad18a364f186
> ("powerpc/rtas_flash: Free kmem upon module exit"),  from the powerpc
> tree and commit 5c0333c00ff6 ("ppc: Clean up rtas_flash driver
> somewhat")
> from the vfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no
> action
> is required).

Please don't merge Dave's rework until it's been acked & fully tested by
us. AFAIK, there are outstanding comments from my guys who
reviewed/tested the first pass.

Cheers,
Ben.
