Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <200508290845.34544.arnd@arndb.de>
References: <20050829130133.519391c6.sfr@canb.auug.org.au>
	<200508290845.34544.arnd@arndb.de>
Content-Type: text/plain
Message-Id: <1126037554.25148.41.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 06 Sep 2005 15:12:36 -0500
Subject: Re: [PATCH 0/3] Start the merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-08-29 at 01:45, Arnd Bergmann wrote:
> On Maandag 29 August 2005 05:01, Stephen Rothwell wrote:
> 
> > Please send at least the first upstream.  The other two can also probably
> > be sent.
> 
> These certainly look good to me.
> 
> This is another patch to merge the atomic.h file. It is not completely
> trivial and changes the semantics for 32 bit SMP systems, which previously
> did not do EIEIO_ON_SMP within the atomic operations. AFAICT, that was
> a bug in the 32 bit version, which is now fixed as a side-effect of
> the merge.
> 
> The combined version of this file also prevents building user space
> applications using atomic.h on ppc64. That was already impossible
> on 32 bit ppc, but probably also created broken output on ppc64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> --
> 
>  include/asm-ppc/atomic.h                  |  214 ------------------------------
>  include/asm-ppc64/atomic.h                |  197 ---------------------------
>  include/asm-ppc64/memory.h                |   59 --------
>  linux-2.6.12/include/asm-powerpc/atomic.h |  209 +++++++++++++++++++++++++++++
>  linux-2.6.12/include/asm-powerpc/memory.h |   59 ++++++++
>  linux-2.6.12/include/asm-ppc/io.h         |   11 -
>  6 files changed, 269 insertions(+), 480 deletions(-)

Paul,

I'd like to call attention to this buried patch.  It appears that
it might be lost due to Subject: line swiping;  it likely hasn't
gotten first class status as its own independent patch.

Any chance we can get this one reviewed and pushed upstream too?

Thanks,
jdl
