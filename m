Message-ID: <3973935A.A01A7CC3@m2tech.co.nz>
Date: Tue, 18 Jul 2000 11:14:34 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: X-Server for 823?
References: <001e01bfeffd$9ba35440$640a0a0a@server>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo Scaffardi wrote:

> How can i run simple X applications on my MPC823 FADS?
> I'd like to enable S-Video output and to use the frame buffer X-Server...
> did anyone implement a X-server or a frame-buffer device for the 823?
>
> Thanx in advance..
>

we have an x-server running on 4xx core (ibm romeo stb chip), initially using
s-video output, but then modulated composite.. i'm afraid the framebuffer
source wont help you but i thought you might want to be aware of the flicker
problem of televisions..

we have implemented software flicker-free control, but this hogs cpu time, and
will be moving to a hardware flicker-free option in the near future.. we had
to patch the x-server to implement the flicker-free control and this is far
from optimal.. i would make sure either the fads board you are using is dammn
quick, or has built in hardware flicker-free filters..

cheers,

ben

--
/\\------------------------------------------------------------------
:::::::::::..ben.b..m2technologyltd.nz..64.9.4448307.130..:::::::::::


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
