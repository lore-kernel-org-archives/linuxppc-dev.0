Message-Id: <199904230618.PAA13270@pandora.chariot.net.au>
Subject: 2.2.5 won't build: ld error
Date: Fri, 23 Apr 1999 15:48:08 +0930
From: Keith Jacob <kjacob@chariot.net.au>
To: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm at a total loss here. I have Gary's latest dev tools for R4 on my 
7200/75, but I cannot build 2.2.5 (rsync from samba.anu.edu.au). It 
compiles OK, but ld chokes with this error:

drivers/video/video.a \
        /usr/src/linux-pmac-2.2.5/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.a(sock_n_syms.o)(__ksymtab+0x430): undefined reference to 
`netdev_state_change'
make: *** [vmlinux] Error 1


2.2.5 has prelim support for Contour Mouse, which I was hoping to test 
drive.

2.1.127, 2.1.131 and 2.2.0 kernels have all built fine for me; 2.1.24 
still builds OK, too.

Help, please!

TIA,

Keith

--
Keith Jacob
kjacob@chariot.net.au


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
