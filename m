Message-Id: <200009231708.TAA00731@piglet.grunz.lu>
Date: Sat, 23 Sep 2000 19:08:37 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
To: daenzerm@student.ethz.ch
cc: reshapiro@mediaone.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39CCC5AB.C1C2E8B2@student.ethz.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  23 Sep, this message from Michel Dänzer echoed through cyberspace:
>> Also the screen is oddly "wrapped" on the rage II machine with the fbdev
>> driver: I can see the full screen but the virtual edge starts about 75% in,
>> instead of matching the physical edge, and then wraps around.  I don't see
>> this artifact on the rage pro G3.
>
> This is a known problem, which is also kind of fixed in Ani's tree AFAIK. I'm
> currently working with Geert Uytterheuven to get the definite fix.

Is this the already-known problem of handling an offset for the screen
start within the framebuffer memory?

Because I'm experiencing this as well with fbdev, and the problem is the
same for all Apple non-accelerated framebuffers (control, platinum,
valkyrie), AFAICT. So it would be helpful if this problem would get
fixed once and for all. FWIW, no propblem with XF3.x.

Thanks

Michel (the other one)

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
