Subject: Re: AGP : ATI128,powerpc
From: Vincent Katz <vincent.katz@laposte.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org, jhartmann@precisioninsight.com,
	paulus@samba.org
In-Reply-To: <20011115144502.20832@smtp.adsl.oleane.com>
References: <1005833543.16135.143.camel@avalon>
	<20011115144502.20832@smtp.adsl.oleane.com>
Content-Type: text/plain
Date: 15 Nov 2001 18:21:15 +0100
Message-Id: <1005844877.16584.190.camel@avalon>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok thanks, i understand the problem ;-)
this, go against my frame of mind but i yield (i m not narrow-minded ;-)
), meanwhile the update of the official, i'll use your rsync.
 thx for all, good luck.

thx also for my gpm problem :-)

vince.

On 15 Nov 2001 15:45:02 +0100, Benjamin Herrenschmidt wrote:
> >PPC machine : TiBook (Powerbook Titanium)
> >ATY : aty128fb: Rage Mobility M3 (AGP) [chip rev 0x0] 8M 128-bit SDR
> >SGRAM (1:1)
> >
> >Is it possible to add in the flush_cache function a
> >"defined(__powerpc__)"  like alpha, sparc ..or i386 .. ?
> >
> >When the function flush_cache in the file "agpgart_be.c" ll be updated
> >in the offical kernel for ppc cpu ?
>
> It's more than flush cache that is needed ;) flush_cache alone will
> eventually allow AGP to compile, not to work.
>
> Get my current rsync tree from rsync.penguinppc.org::linux-2.4-benh,
> it has complete support for UniNorth AGP on r128. (the M3 you have in
> your Pismo is an r128). Beware however that accelerated GL via DRI
> is known to crash with this chip for reasons not yet determined.
>
> I've sent my current patches to the DRI mailing list, I can't say
> yet when all this will appear upstream as some merging has to be
> done with other archs using the "special" agp_ioremap. I will submit
> the AGP part of the patch directly to linus/marcello once I'm in sync
> with DRI people, there's no need to send it until something can use it ;)
>
> Ben.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
