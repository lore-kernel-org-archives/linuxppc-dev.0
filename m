Message-ID: <371788C8.71A9F14@fi.infn.it>
Date: Fri, 16 Apr 1999 21:00:24 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: David De Ridder <david.de.ridder@bitsmart.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: First attempt for LinuxPPC on a MVME2400
References: <3.0.6.32.19990416174803.008106a0@hsins.uia.ac.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David, 
thanks for the advice, I'll keep in my mind.
I tried the test that you suggested in the previuos mail, but I got no
answer from the board. In any case I still have to set up a root tree,
so the nfs cannot work in any case. We have also to buy a disk for the
board, but this will be a further step.
It seems that the crash is a problem of the Hawk chip, from PPCBug the
board is capable to ping, and also to connect to the tftp daemon and
load the kernel image.
Now I'm triyng to set up the cross-copiler using the procedure given by
Matt Porter in his web page, but the CVS repository changed location,
and the downloading procedure; for people tha can need this information
the new site is http://cvs.on.openprojects.net/ 
I just finished the download. I'll try some compilation, I'm quite far
from getting the board working, but at least I'm on my way.
Thanks again
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
