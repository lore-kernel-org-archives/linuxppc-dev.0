Message-ID: <3EA023F2.820B65C0@doremilabs.com>
Date: Fri, 18 Apr 2003 16:12:34 +0000
From: Jeff H Zhong <jeff@doremilabs.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging using bdi2000, unable to proceed.
References: <20030418222217.E5F71C58B9@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
We may need one more variable to be passed to kernel and let kernel know
if we want initialize ethernet or not?

--Jeff

> > Wolfgang Denk wrote:
> > >
> > > in message <3E9FB7FD.93947BE5@doremilabs.com> you wrote:
> > > >
> > > > Could you give me a hand to help me figure out this issue on ebony?
> > >
> > > I've read your story before, but I cannot help.
> > >
> > > > If I use "bootp" or "tftp" to load kernel image(linuxppc_2_4_devel from
> > > > BK) at address 0x01000000 and then issue "bootm", everything works fine.
> > > > I have also programmed the image into flash at 0xffe00000, but each time
> > > > when I issue "bootm 0xffe00000", it will get stuck at when trying to
> > > > mount NFS.
> > >
> > > Technically there is absolutely no difference between both cases:  in
> > > either  case  U-Boot  will  copy  and  uncompress  the  kernel to RAM
> > > starting at physical adress 0x0000, and start it there.  I  have  not
> > > the slightest idea whaty could cause a behaviour as described by you,
> > > nor have I ever seen anything like that before.
>
> Well, there _is_ one obvious difference: when you use "tftp" to  load
> kernel  then  U-Boot  will  perform the initialization of the network
> interface. You can perform a simple test for this:
>
> Do a dummy TFTP download, and then try  to  "bootm"  the  image  from
> flash. I bet it'll work.

--
Jeff H. Zhong
-------------
Doremi Labs, Inc.
306 East Alameda Avenue
Burbank, CA 91502

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
