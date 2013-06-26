Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 627E32C037B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 18:10:48 +1000 (EST)
Message-ID: <1372234231.18612.6.camel@pasglop>
Subject: Re: linux-next: manual merge of the akpm tree with the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 26 Jun 2013 18:10:31 +1000
In-Reply-To: <20130626165642.8740ecb6d5d5882b06f173c8@canb.auug.org.au>
References: <20130626165642.8740ecb6d5d5882b06f173c8@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-next@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-26 at 16:56 +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the akpm tree got a conflict in
> arch/powerpc/kernel/ptrace.c between commit b0b0aa9c7faf
> ("powerpc/hw_brk: Fix setting of length for exact mode breakpoints") from
> the powerpc tree and commit "ptrace/powerpc: revert "hw_breakpoints: Fix
> racy access to ptrace breakpoints"" from the akpm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Where does the latter come from ? Why didn't it go through the powerpc tree ?

Cheers,
Ben.
