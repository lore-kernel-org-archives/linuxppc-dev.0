Message-ID: <1080318719206.mikko.alutoin.17604.2qSxXdx65WQeg1tDzWIhzQ@luukku.com>
Date: Fri, 26 Mar 2004 18:31:59 +0200 (EET)
From: Mikko Alutoin <mikko.alutoin@luukku.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with MMU again
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks!

I am stuck and need your help.
We have our own board with MPC8260 on it running Linux 2.4.18. I have been building new images for the system routinely for quite a some time, but now I am faced with a strange problem. I applied one of the USAGI projects kernel patches (in order to have IPv4/IPv6 dual-stack) and now something goes very wrong when jumping to start_kernel. I used Abatron BDI 2000 to trace over the rfi instruction at the end of start_here, after which I found myself in the middle of InstructionAddressInvalid in the exception vector - not in the virtual address of start_kernel where I wanted to be, buuaaah! (Simultaneously Abatron complained that 'step timeout detected' or something like that.)
I am confused. How come the boot code now fails to get the MMU working, as the USAGI patch should not have touched any of the kernel initialization code (to my knowledge at least). Could it be because start_kernel is now at a higher adress than it used to? I know that I am not probably giving much to go on here, but I would be glad to even get some hints where to look for more information.

Cheers,
Mikko

..............................................................
 MTV3 Laajakaista - Hauskemman elämän puolesta.
 http://www.mtv3.fi/liittyma/hankinta/laajakaista/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
