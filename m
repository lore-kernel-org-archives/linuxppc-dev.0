Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F4681A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 07:03:31 +1100 (AEDT)
Date: Fri, 8 Jan 2016 07:03:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc tree
Message-ID: <20160108070330.0a2fcb89@canb.auug.org.au>
In-Reply-To: <87ziwhpazc.fsf@linux.vnet.ibm.com>
References: <20151218163351.5bfd2def@canb.auug.org.au>
 <20160107201503.6d5ec159@canb.auug.org.au>
 <87ziwhpazc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On Thu, 07 Jan 2016 22:45:19 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > This merge fix up patch now looks like this:  
> 
> 
> What about the #define pfn_pte part ? We don't need that now ?

That is done as part of the merge conflict resolution.  This is an
extra needed merge resolution patch due to code being moved between
files.  You can see the entire merge resolution using

  git diff-tree --cc 5a028bd9b7de

in next-20160107.

The #defines are there in

  arch/powerpc/include/asm/book3s/32/pgtable.h
  arch/powerpc/include/asm/book3s/64/hash.h
  arch/powerpc/include/asm/nohash/pgtable.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
