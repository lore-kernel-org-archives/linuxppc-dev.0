Subject: Re: linuxppc-2.5 from mvista.com -- drivers/char/agp/agp.h:31:
	asm/agp.h: No such file or directory
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: miles.lane@attbi.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200303241737.LAA16808@lists.linuxppc.org>
References: <200303241737.LAA16808@lists.linuxppc.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1048528618.5401.36.camel@thor>
Mime-Version: 1.0
Date: 24 Mar 2003 18:56:59 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-03-24 at 18:37, miles.lane@attbi.com wrote:
>   gcc -Wp,-MD,drivers/char/agp/.backend.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple
> -mstring -fomit-frame-pointer -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=backend -DKBUILD_MODNAME=agpgart -c -o
> drivers/char/agp/backend.o drivers/char/agp/backend.c
> In file included from drivers/char/agp/backend.c:39:
> drivers/char/agp/agp.h:31: asm/agp.h: No such file or directory
> In file included from drivers/char/agp/backend.c:39:
> drivers/char/agp/agp.h: In function `global_cache_flush':
> drivers/char/agp/agp.h:51: warning: implicit declaration of function
> `flush_agp_cache'
> make[3]: *** [drivers/char/agp/backend.o] Error 1

I did

cp include/asm-{alpha,ppc}/asm.h

to get it to build - there's no UniNorth agpgart in linuxppc-2.5 yet
anyway, so I guess you enabled CONFIG_AGP for CONFIG_DRM_RADEON like I
did. :)


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
