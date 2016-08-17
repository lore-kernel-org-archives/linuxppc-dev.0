Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDq860tV0zDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 23:00:06 +1000 (AEST)
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
References: <20160817114443.67675413@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
From: Michal Marek <mmarek@suse.cz>
Message-ID: <e6fbe17c-1981-1579-433d-88462d2efb58@suse.cz>
Date: Wed, 17 Aug 2016 14:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <20160817114443.67675413@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-08-17 03:44, Stephen Rothwell wrote:
> Hi Michal,
> 
> After merging the kbuild tree, today's linux-next build (powerpc
> ppc64_defconfig) produced these warnings:
> 
> WARNING: 25 bad relocations
> c000000000cf2570 R_PPC64_ADDR64    __crc___arch_hweight16
[...]
> Introduced by commit
> 
>   9445aa1a3062 ("ppc: move exports to definitions")
> 
> I have reverted that commit for today.
> 
> [cc-ing the ppc guys for clues - also involved is commit
> 
>   22823ab419d8 ("EXPORT_SYMBOL() for asm")
> ]

FWIW, I see these warnings as well. Any help from ppc developers is
appreciated - should the R_PPC64_ADDR64 be whitelisted for exported asm
symbols (their CRCs actually)?

Thanks,
Michal
