Message-ID: <3727628A.80F872F4@fi.infn.it>
Date: Wed, 28 Apr 1999 21:33:30 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Extremely near to a working syste
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Thanks to the many helps that I get, I'm now extremely near to a working
system on a MVME2301 board.

I successfully cross-compiled a PPC kernel using a RedHat 5.2 on a PC,
and I could boot from this, I also setup the bootp and nfs server on my
machine having the kernel finding the root directory on my PC. 

The only thing I'm lacking is a ppc root tree. I tried to use a debian
tree that I take from here: 
ftp://ftp.debian/org/pub/debian/dists/potato/main/disks-powerpc/2.1.8-1999-02-24/base2_2.tgz
but what I had (after booting) is:

[snip]
Sending BOOTP requests....eth0: media is TP.
. OK
IP-Config: Got BOOTP answer from 192.84.146.24, my address is
192.84.146.131
IP-Config: Gateway not on directly connected network.
Looking up port of RPC 100003/2 on 192.84.146.24
Looking up port of RPC 100005/1 on 192.84.146.24
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 60k init 4k pmac 8k open firmware
INIT: version 2.76 booting
INIT: No inittab file found

Enter runlevel: 1
INIT: Entering runlevel: 1
INIT: no more processes left in this runlevel

and here it hangs. I never used debian, but effectively there is no
/etc/inittab in the tree, I have to get one of there something missing?
(or it seems to me that the mount was fine, but I'm wrong ?

I also try to make a RedHat tree, but the problem is that also by giving
the --root=/... option (and the --ingnorearch also) I cannot execute the
postinstallation scripts: while I was installing libraries this was not
a problem, because they simply call ldconfig and I skipped they with
--noscripts, but when I try to install other packages (like bash for
example) they execute  more complex scripts, that I have to do by hand,
and before to do this for all the packages, I would like to know if
there a cleaner (and faster) way to do this work.

Thanks you againg for all the help, I could'nt even believe to be
capable to get a so near working system in so few time!

Bye
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
