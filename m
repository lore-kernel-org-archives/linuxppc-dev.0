Subject: Re: AGP : ATI128,powerpc
From: Vincent Katz <vincent.katz@laposte.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: jhartmann@precisioninsight.com, paulus@samba.org,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011114212629.29843@smtp.wanadoo.fr>
References: <1005771164.6732.19.camel@avalon>
	<20011114212629.29843@smtp.wanadoo.fr>
Content-Type: text/plain
Date: 15 Nov 2001 15:12:22 +0100
Message-Id: <1005833543.16135.143.camel@avalon>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
thanks for your reply.

PPC machine : TiBook (Powerbook Titanium)
ATY : aty128fb: Rage Mobility M3 (AGP) [chip rev 0x0] 8M 128-bit SDR
SGRAM (1:1)

Is it possible to add in the flush_cache function a
"defined(__powerpc__)"  like alpha, sparc ..or i386 .. ?

When the function flush_cache in the file "agpgart_be.c" ll be updated
in the offical kernel for ppc cpu ?

thanks.

On 14 Nov 2001 22:26:29 +0100, Benjamin Herrenschmidt wrote:
> >Linux version : 2.4.14
> >File with a supposed probleme : linux/drivers/char/agp/agpgart_be.c
> >
> >I have a powerpc with an ati128 AGP.
> >
> >When i compile the kernel i have this error : error "Please define
> >flush_cache."
> >
> >this error come from the function flush_cache in agpgart_be.c where
> >definition for powerpc are not setting . Why ?
>
> What PPC machine is this ? I added support for Apple's UniNorth
> chipset in my kernel (patch submited to dri-devel a few days ago)
> along with the necessary r128 DRM changes to work around HW bugs.
>
> (My rsync tree is at rsync.penguinppc.org::linux-2.4-benh).
>
> If you are using a different chipset, then my code may not help
>
> Ben.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
