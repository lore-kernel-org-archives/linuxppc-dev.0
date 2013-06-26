Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 210152C02A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:13:27 +1000 (EST)
Date: Wed, 26 Jun 2013 06:13:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: manual merge of the akpm tree with the powerpc tree
Message-Id: <20130626061300.6b2da9e3.akpm@linux-foundation.org>
In-Reply-To: <1372234231.18612.6.camel@pasglop>
References: <20130626165642.8740ecb6d5d5882b06f173c8@canb.auug.org.au>
 <1372234231.18612.6.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 26 Jun 2013 18:10:31 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2013-06-26 at 16:56 +1000, Stephen Rothwell wrote:
> > Today's linux-next merge of the akpm tree got a conflict in
> > arch/powerpc/kernel/ptrace.c between commit b0b0aa9c7faf
> > ("powerpc/hw_brk: Fix setting of length for exact mode breakpoints") from
> > the powerpc tree and commit "ptrace/powerpc: revert "hw_breakpoints: Fix
> > racy access to ptrace breakpoints"" from the akpm tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary (no action
> > is required).
> 
> Where does the latter come from ? Why didn't it go through the powerpc tree ?

um, the most rudimentary search will take you to Oleg's patch series. 
You were cc'ed on the whole thing two or three times.
