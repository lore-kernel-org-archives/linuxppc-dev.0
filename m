From: Michael Engel <engel@math.uni-siegen.de>
Message-Id: <199906230224.EAA24948@fourier.numerik.math.uni-siegen.de>
Subject: Xbh not working (Cirrus X server)
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 23 Jun 1999 04:24:09 +0200 (MET DST)
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I'm experiencing a problem with Xbh on the Motorola PowerStack Series E
and PowerStack II here. Xbh crashes with segmentation fault shortly after
starting the server, gdb shows that the server is crashing in
gd54xx_memsize
(in xc/programs/Xserver/hw/bh/gd54xx.c). I built XFree from source
(rpm --rebuild) with the same result. When setting a fixed memsize of 2 MB
in gd54xx_memsize, the server crashes in outb() in
gd54xx_setcolor

I can provide the complete gdb bt output if necessary.

It seems that there's something severely wrong with card or base address
detection. I don't know a thing about programming X servers, so I'm really 
lost here. Any ideas what I can do to get it running ?

regards,
	Michael Engel	(engel@unix-ag.org)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
