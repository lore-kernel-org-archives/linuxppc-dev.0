Message-ID: <3A963519.C439E7C0@valinux.com>
Date: Fri, 23 Feb 2001 21:02:01 +1100
From: Gareth Hughes <gareth@valinux.com>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com> <v04220800b6bbb8f01525@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:
>
> The second is that the DRM kernel modules fail to build against the
> 2.2.18 headers.  A function in vm.c (I think) tries to access a field
> named 'virtual' in struct page, which simply isn't there in 2.2.18.
> The #if statements surrounding the code seem to be deliberately
> compiling it only if the kernel is a 2.2 series, so I'm not sure what
> is going on.  So I shifted over to the PPC 2.4 BK kernels and got
> everything to build OK that way.

2.2 was never really well supported.  We've been using 2.4 for a long
time...

> Where I'm at now is that the X server loads and runs (quite well I
> might add), automatically loads the r128.o kernel module, and (in the
> logfile) claims to have enabled direct rendering.  However, both
> windowed and fullscreen GL apps are very clearly not being
> accelerated.  Frame rates are obviously software renderer type frame
> rates, and apps which check for multitexture capability complain that
> it isn't there.
>
> Any suggestions?  If anybody wants to see some logs from the server
> starting up, I'll supply 'em.  Also, if anybody out there has gotten
> this working, could you send me your XF86Config so I can make sure I
> didn't do something silly to mine?

Run with LIBGL_DEBUG=1 and see what it says.  Also, try the glxinfo
program (available from the DRI resources page) or Mesa/demos/glinfo --
these print out information about the OpenGL library being used.

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
