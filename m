Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6x2lnlzDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:26:01 +1100 (AEDT)
In-Reply-To: <1488801917-17782-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sfr@canb.auug.org.au, andrew.donnellan@au1.ibm.com
Subject: Re: powerpc: Sort the selects under CONFIG_PPC
Message-Id: <3vdQ6x0PHWz9sNJ@ozlabs.org>
Date: Wed,  8 Mar 2017 18:26:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-06 at 12:05:17 UTC, Michael Ellerman wrote:
> We have a big list of selects under CONFIG_PPC, and currently they're
> completely unsorted. This means people tend to add new selects at the
> bottom of the list, and so two commits which both add a new select will
> often conflict.
> 
> Instead sort it alphabetically. This is nicer in and of itself, but also
> means two commits that add a new select will have a greater chance of
> not conflicting.
> 
> Add a note at the top and bottom asking people to keep it sorted.
> 
> And while we're here pad out the 'if' expressions to make them stand
> out.
> 
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/a7d2475af7aedcb9b5c6343989a8bf

cheers
