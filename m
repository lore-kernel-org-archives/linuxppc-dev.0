Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the final tree (powerpc
 tree related)
In-reply-to: <20130111165241.44a5ede6b24c997810be74e1@canb.auug.org.au>
References: <20130111165241.44a5ede6b24c997810be74e1@canb.auug.org.au>
Date: Fri, 11 Jan 2013 17:04:06 +1100
Message-ID: <28677.1357884246@ale.ozlabs.ibm.com>
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> arch/powerpc/kernel/kgdb.c: In function 'kgdb_arch_exit':
> arch/powerpc/kernel/kgdb.c:492:2: error: '__debugger_breakx_match' undeclared (first use in this function)
> 
> Caused by commit 9422de3e953d ("powerpc: Hardware breakpoints rewrite to
> handle non DABR breakpoint registers").  I applied "powerpc: Fix typo in
> breakpoint kgdb code" from Mikey for this.
> 
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:1204: Error: attempt to move .org backwards
> 
> Not sure what caused that - probably a combination of patches adding code
> low down.  I have just left this broken for today.

FWIW I posted this earlier

http://patchwork.ozlabs.org/patch/211184/

Mikey
