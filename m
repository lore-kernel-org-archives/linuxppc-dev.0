From: nicolas.boussekeyt@afoc.alcatel.fr
To: linux-kernel@vger.rutgers.edu, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Compilation Problem with kernel 2.2.9
Message-Id: <"/GUID:QPEp010Ul0xGPlQAQS7cwaA*/G=nicolas/S=boussekeyt/O=afoc/PRMD=acab/ADMD=atlas/C=fr/"@MHS>
Date: 18 Jun 1999 14:31:58 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I have a problem with my PB G3.
When I compile the kernel, I have this message:
gcc -D__KERNEL__ -I/usr/src/linux-2_2_9/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__SMP__ -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -c -o pmac_setup.o pmac_setup.c
pmac_setup.c: In function `pmac_init':
pmac_setup.c:559: `ISA_DMA_THRESHOLD' undeclared (first use this function)
pmac_setup.c:559: (Each undeclared identifier is reported only once
pmac_setup.c:559: for each function it appears in.)
pmac_setup.c:560: `DMA_MODE_READ' undeclared (first use this function)
pmac_setup.c:561: `DMA_MODE_WRITE' undeclared (first use this function)
make[1]: *** [pmac_setup.o] Error 1  

What can i do to compile the kernel ? 
thank you in advance.



                                         Nicolas BOUSSEKEYT
                                         ALCATEL Fibre Optique
                                        Tel : 03 21 79 49 00
                                        Web : http://www.alcatel.fr

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
