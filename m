Mime-Version: 1.0
Message-Id: <v04210100b3dd6a1829b5@[63.192.35.210]>
Date: Mon, 16 Aug 1999 01:10:43 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Erwin Frise <erwin@fruitfly.BDGP.Berkeley.EDU>
Subject: atyfb with ATI 264VT?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After upgrading from R4 to R5, I have been trying to get accelerated 
XFree86 on my Starmax 4200 with the onboard video chip (ATI 264VT) 
using the atyfb and kernel 2.2.10 (precompiled from Paul), booting 
via BootX 1.1.3.

No matter what resolution/bit depth I choose I cannot get the kernel 
atyfb to work: I get double text characters in 8 bit color mode, 
totally screwed palette in 16 bit and a black screen with lots of 
vertical lines everytime something gets written to the terminal in 
24/32 bit (when starting XFree86, the results were similar). Playing 
around with the mclk values didn't change anything at all. Out of 
convenience I haven't used atyfb much since I started using BootX 
(accelerated Xpmac worked "no video" checked too) but I believe that 
atyfb was working fine with 2.1.24 in the early R4 release when I was 
still using OF to boot.

Does anyone know what's going on or how to get the atyfb in the 
current kernels to work with the ATI VT chip? Is there any obvious 
problem/solution which I could try to do? At some point apparently 
the VT chip worked, so what has changed since then? I saw that there 
are still lots of references for the ATI VT chip in the atyfb.c 
driver in the kernel code; however don't understand enough about 
graphics chip programming to make any meaningful tweaks. I have been 
following the discussion about the atyfb on the G3. Perhaps I could 
also try to use Geert's atyfb_dsp_debug program but I'm a bit 
reluctant to play around with parameters I don't understand and 
perhaps fry my graphics chip.

LinuxPCC has become a very important part of my daily work and 
despite of those problems I wish to thank all the developers out 
there. I'd be very grateful if someone could give me some clues, 
guidelines or tips.

TIA,

Erwin
-- 

Erwin Frise
Bioinformatics scientist
Berkeley Drosophila Genome Project
Life Science Addition #3200
University of California
Berkeley, CA 94072-3200

Tel: (510) 643-0269
Email: erwin@fruitfly.berkeley.edu

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
