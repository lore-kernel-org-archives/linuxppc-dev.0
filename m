Message-ID: <39CE25AF.E29D265F@wanadoo.fr>
Date: Sun, 24 Sep 2000 18:02:55 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Michel Dänzer <daenzerm@student.ethz.ch>
CC: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
References: <200009231708.TAA00731@piglet.grunz.lu> <39CE0203.FA1205E9@student.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> Michel Lanners wrote:
[]
> > Because I'm experiencing this as well with fbdev, and the problem is the
> > same for all Apple non-accelerated framebuffers (control, platinum,
> > valkyrie), AFAICT. So it would be helpful if this problem would get

For what it's worth: I have *no* problem with Franz's 4.0.1 RPMs and a
valkyrie display. It works for 8 bit color without and for 15 bit color
with a modeline in XFConfig. It doesn't work for 16 bit color (and more
than that is out of reach for valkyrie with 1MB VRAM).

> > fixed once and for all. FWIW, no propblem with XF3.x.
>
> That's why I'm working with Geert, who wrote the 3.x code :)
>
> I'm currently having problems with the MMIO mapping of his code, will
> investigate. The Vidmem mapping works for me (although it also worked before),
> so any volunteers for testing please line up to me for a patch :)

I'd volunteer if you provide a precompiled server binary. For compiling
XFree86 myself, my machine is too slow.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
