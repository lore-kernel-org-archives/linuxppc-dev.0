Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8766D1A0BA2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 13:27:22 +1000 (AEST)
Message-ID: <1428463642.29968.1.camel@ellerman.id.au>
Subject: Re: powerpc32: fix warning from include/linux/mm.h
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 08 Apr 2015 13:27:22 +1000
In-Reply-To: <20150320235213.GA1233@home.buserror.net>
References: <20141205112020.640FA1A5D4F@localhost.localdomain>
 <20150320235213.GA1233@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-20 at 18:52 -0500, Scott Wood wrote:
> On Fri, Dec 05, 2014 at 12:20:20PM +0100, LEROY Christophe wrote:
> > include/linux/mm.h: In function 'is_vmalloc_addr':
> > include/linux/mm.h:367:14: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> >   return addr >= VMALLOC_START && addr < VMALLOC_END;
> >               ^
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >  arch/powerpc/include/asm/pgtable-ppc32.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> That warning doesn't appear to be enabled.  What config are you seeing
> this with?
> 
> I'm also not clear on why this was assigned to me in patchwork.

Because it's from Christophe.

cheers
