Subject: Re: linuxppc-2.5 from mvista.com -- drivers/char/agp/agp.h:31:
	asm/agp.h: No such file or directory
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: miles.lane@attbi.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1048528618.5401.36.camel@thor>
References: <200303241737.LAA16808@lists.linuxppc.org>
	 <1048528618.5401.36.camel@thor>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1048532438.5409.46.camel@thor>
Mime-Version: 1.0
Date: 24 Mar 2003 20:00:39 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-03-24 at 18:56, Michel Dänzer wrote:
> On Mon, 2003-03-24 at 18:37, miles.lane@attbi.com wrote:
> >   gcc -Wp,-MD,drivers/char/agp/.backend.o.d -D__KERNEL__ -Iinclude -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple
> > -mstring -fomit-frame-pointer -nostdinc -iwithprefix include
> > -DKBUILD_BASENAME=backend -DKBUILD_MODNAME=agpgart -c -o
> > drivers/char/agp/backend.o drivers/char/agp/backend.c
> > In file included from drivers/char/agp/backend.c:39:
> > drivers/char/agp/agp.h:31: asm/agp.h: No such file or directory
> > In file included from drivers/char/agp/backend.c:39:
> > drivers/char/agp/agp.h: In function `global_cache_flush':
> > drivers/char/agp/agp.h:51: warning: implicit declaration of function
> > `flush_agp_cache'
> > make[3]: *** [drivers/char/agp/backend.o] Error 1
>
> I did
>
> cp include/asm-{alpha,ppc}/asm.h
                             ^^^^^
D'oh, make that agp.h .


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
