Subject: Re: mvista.com rsync linuxppc-2.5 --
	drivers/char/drm/drm_memory.h:145: `radeon_mem_stats' undeclared (first use
	in this function)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Miles Lane <miles.lane@attbi.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3EB869AF.7070202@attbi.com>
References: <3EB869AF.7070202@attbi.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1052296603.15229.172.camel@thor>
Mime-Version: 1.0
Date: 07 May 2003 10:36:43 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mit, 2003-05-07 at 04:04, Miles Lane wrote:
>
>    gcc -Wp,-MD,drivers/char/drm/.radeon_drv.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
> -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include
>     -DKBUILD_BASENAME=radeon_drv -DKBUILD_MODNAME=radeon -c -o
> drivers/char/drm/radeon_drv.o drivers/char/drm/radeon_drv.c
> In file included from drivers/char/drm/radeon_drv.c:49:
> drivers/char/drm/drm_memory.h: In function `radeon_ioremap_agp':
> drivers/char/drm/drm_memory.h:145: `radeon_mem_stats' undeclared (first
> use in this function)
> drivers/char/drm/drm_memory.h:145: (Each undeclared identifier is
> reported only once
> drivers/char/drm/drm_memory.h:145: for each function it appears in.)
> drivers/char/drm/drm_memory.h:157: `radeon_mem_lock' undeclared (first
> use in this function)
> drivers/char/drm/drm_memory.h: In function `radeon_ioremap_agp_free':
> drivers/char/drm/drm_memory.h:212: `radeon_mem_stats' undeclared (first
> use in this function)
> drivers/char/drm/drm_memory.h:216: `radeon_mem_lock' undeclared (first
> use in this function)
> make[3]: *** [drivers/char/drm/radeon_drv.o] Error 1

I've fixed this in my local DRI tree and can come up with a patch for
linuxppc-2.5 if nobody beats me to it.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
