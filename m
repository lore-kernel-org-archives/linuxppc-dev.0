From: raphael.bossek@solutions4linux.de
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 24 Nov 1999 08:45:14 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: newbie: get ppc823fads working with linux 2.3.x kernel...
Message-Id: <E11qX1y-0007yx-00@mx00.kundenserver.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

i tried here to cross-compile the unstable linux kernel for the FADS 
ppc823 evaluation board but i get ONLY errors while compiling... For 
instance the serial.c source does not compile or other stuff too...

Where will be CONFIG_FADS #defined ? The 8xx_io/fec.c and 
mbxboot/mbxtty.c files check for that... I thing that the PowerPC 
configuration menu miss this token...

Will patches be collected somewhere so i can get reported bug fixed 
within the kernel ?

thx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
