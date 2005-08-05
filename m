Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 5 Aug 2005 18:37:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linuxppc64-dev@ozlabs.org
Message-Id: <20050805183756.25c65e08.sfr@canb.auug.org.au>
In-Reply-To: <20050805174705.731ffa05.sfr@canb.auug.org.au>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<688ba2276de281a9473b030a16a514c0@embeddededge.com>
	<20050805174705.731ffa05.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
 Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 5 Aug 2005 17:47:05 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> for i in *
> do
> 	[ -f ../asm-ppc64/$i ] && cmp -s $i ../asm-ppc64/$i &&
> 		mv $i ../asm-powerpc/$i && rm ../asm-ppc64/$i
> done

note to self:  Never modify stuff in an email :-(
that should be

[While in .../asm-ppc64 ]

for i in *
do
	[ -f ../asm-ppc/$i ] && cmp -s $i ../asm-ppc/$i &&
		mv $i ../asm-powerpc/$i && rm ../asm-ppc/$i
done

Sorry about that!
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
