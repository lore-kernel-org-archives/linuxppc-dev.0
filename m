Date: Mon, 17 May 1999 10:32:48 +1000
Message-Id: <199905170032.KAA08770@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
Subject: accel X server for C&T 65550?
Reply-to: Paul.Mackerras@cs.anu.edu.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know of an accelerated X server for the C&T 65550 video
chip found on the powerbook 3400?  I know about Fabio Riccardi's
server, of course, but I was wondering if anyone had put the
acceleration into the updated Xpmac or into XF68_FBDev.

Also, has anyone actually hacked the chipsfb.c driver to add an ioctl
to switch the external video output on and off?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
