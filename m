Message-Id: <v04003a00b3b7de41a7b6@[10.0.0.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 18 Jul 1999 15:51:53 -0400
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user-digest@lists.linuxppc.org
From: Paul Barrette <barretp@mcmail.cis.mcmaster.ca>
Subject: some progress: opening display /platinum@F8000000... failed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I compiled my old kernel src, 2.2.2 and loaded it in the approp. place.
I used my old OF settings that booted fine with kernel 2.2.2  on R4.   I
compiled with the same .config file (after a make mrproper).

NB it gave me the same problem! opening display /platinum@F8000000... failed
However, at least the kernel boots with a nasty screen, and boots fine
screen and all from bootx.  So this suggests that 2.2.6-15 has some boot
issues concerning the 7200.

here is the quik.conf:
root = /dev/sda5
timeout = 300

#kernel 2.2.2 (ipmasq,3com eth cards,autofs) with fixed vram, no bootx
settings!
image = /boot/vmlinux-1
        label = linux
        alias = 1
        append="/boot/vmlinux-1  root=/dev/sda5
video=platinumfb:vmode:12,cmode:8"
<<
I tried boot-file empty and with the append line above, same result.  I
think there is some kind of boot enabler or something in R5 that is
different from R4.

ARe there any new OF issues for R5?

--
Paul Barrette
Ph.D. candidate, dept. of Classics
System Administrator
McMaster University

umbra loco deerat; qua postquam parte resedit
Dis genitus vates et fila sonantia movit,
umbra loco venit.                  (Ov. Met. 10. 88 ff.)
http://www.humanities.mcmaster.ca/~barrette/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
