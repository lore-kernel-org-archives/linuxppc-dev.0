Message-ID: <3861E076.9BFCA5E8@ascom.ch>
Date: Thu, 23 Dec 1999 09:42:30 +0100
From: Ruedi Hofer <ruedi.hofer@ascom.ch>
MIME-Version: 1.0
To: raphael.bossek@solutions4linux.de, linuxppc-embedded@lists.linuxppc.org
Subject: Loading the Kernel on a FADS
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi Raphael, 

I'm still in a much earlier stage than you are. I just managed to get the 
fadsrom working. Now I try to load the kernel (2.3.18) which I've compiled
for the FADS. 

My next steps are now:
1. make zImage of the Kernel
2. mkrombin of the kernel
3. convert to s records
4. load the code with mpc8bug

Problem:
Unfortunately when I try to do a 'mkrombin' of the Kernel the mkrombin exits 
with a message like this:

	nscns:1
	ehp:0x804aee0
	epp:0x804af14
	something wrong with file (1) zImage

Question:
Is my procedure correct?
How do you download the kernelcode to the board?


-- 
Best regards
                                          
Ruedi Hofer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
