Message-ID: <39CE0203.FA1205E9@student.ethz.ch>
Date: Sun, 24 Sep 2000 15:30:43 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: reshapiro@mediaone.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
References: <200009231708.TAA00731@piglet.grunz.lu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> On  23 Sep, this message from Michel Dänzer echoed through cyberspace:
> >> Also the screen is oddly "wrapped" on the rage II machine with the fbdev
> >> driver: I can see the full screen but the virtual edge starts about 75%
> >> in, instead of matching the physical edge, and then wraps around.  I
> >> don't see this artifact on the rage pro G3.
> >
> > This is a known problem, which is also kind of fixed in Ani's tree AFAIK.
> > I'm currently working with Geert Uytterheuven to get the definite fix.
>
> Is this the already-known problem of handling an offset for the screen
> start within the framebuffer memory?

Yes.


> Because I'm experiencing this as well with fbdev, and the problem is the
> same for all Apple non-accelerated framebuffers (control, platinum,
> valkyrie), AFAICT. So it would be helpful if this problem would get
> fixed once and for all. FWIW, no propblem with XF3.x.

That's why I'm working with Geert, who wrote the 3.x code :)

I'm currently having problems with the MMIO mapping of his code, will
investigate. The Vidmem mapping works for me (although it also worked before),
so any volunteers for testing please line up to me for a patch :)


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
