Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlm71ZRfzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:21:11 +1100 (AEDT)
Date: Mon, 30 Jan 2017 21:21:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulmck@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: Re: [PATCH] powerpc: sort Kconfig selects under CONFIG_PPC
Message-ID: <20170130212110.057b788c@canb.auug.org.au>
In-Reply-To: <87lgtsx45f.fsf@concordia.ellerman.id.au>
References: <87y3xtw62l.fsf@concordia.ellerman.id.au>
 <20170130093002.22180-1-andrew.donnellan@au1.ibm.com>
 <20170130204102.423cebea@canb.auug.org.au>
 <87lgtsx45f.fsf@concordia.ellerman.id.au>
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

Hi Michael,

On Mon, 30 Jan 2017 20:56:12 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > On Mon, 30 Jan 2017 20:30:02 +1100 Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:  
> >>
> >> config PPC has a lot of selects under it. They're not sorted in any
> >> particular order, leading to merge conflicts when adding items at the end.
> >> 
> >> Sort them alphabetically.  
> >
> > Excellent, thanks.
> >  
> >> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> >> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> >> ---
> >> 
> >> On top of linux-next 20170130  
> >
> > Probably best done on top of powerpc-next and I can cope with the
> > conflicts one more time.  
> 
> But I don't want to send that many conflicts to Linus.
> 
> What we need to do is generate the patch just after 4.11-rc1 is out,
> that way there should be zero skew between my fixes/next and Linus'
> tree. I've been meaning to do it for a few releases but just never
> remember.
> 
> So Andrew if you can remember to do it then that would be awesome :)
> 
> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >> index 689cf9218b21..570195c8a86a 100644
> >> --- a/arch/powerpc/Kconfig
> >> +++ b/arch/powerpc/Kconfig
> >> @@ -80,91 +80,91 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
> >>  config PPC  
> >
> > Could we add a comment just above asking that the selects be kept in order?  
> 
> Actually at the bottom would make more sense I think, that's where
> people will try to add new ones.

Sure, both good ideas.
-- 
Cheers,
Stephen Rothwell
