From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: <joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 3
Date: Tue, 4 Feb 2003 10:50:43 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJGEGHCNAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <IGEFJKJNHJDCBKALBJLLCEOFFJAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am on an 862. Anyway I can't find another definition of dma_cache_inv() but the NO OP in asm-ppc/io.h. Could you give me e hint
where it is defined in your kernel?

Thanks, Stephan

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@lumentis.se]
> Sent: Montag, 3. Februar 2003 18:23
> To: Stephan Linke
> Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 3
>
>
> > Hi Jocke,
> >
> > in your latest patch you are using dma_cache_inv() instead of invalidate_dcache_range().
> > The only dma_cache_inv() I can find is in include/asm-ppc/io.h. and it's a "do{}while(0)".
> > Are you shure that this was your intention? It seames to me like you could remove that call as well.
>
> I guess you are on 8260? On 8260 there is no need for invalidate_dcache_range() since
> it's the CPM is cache coherent. On 8xx it is not cache coherent. I switched
> to dma_cache_inv() because it's a no op on 8260 and a invalidate_dcache_range() on 8xx so
> it would be easy to adapt the patch to both CPU's.
>
>  Jocke
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
