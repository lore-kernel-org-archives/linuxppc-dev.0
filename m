Message-Id: <200002261850.NAA09507@p2.parker.boston.ma.us>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.3.47 imac build?
Date: Sat, 26 Feb 2000 13:50:41 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Anyone know how to cure the message:

/usr/src/linux-2.3.47/include/linux/fs.h:769: warning: implicit declaration of function `abs'

in the 2.3.47 build?

abs is #defined in stdlib.h but I'm not sure that's used in the kernel builds.

(did I miss some patches?)

-brad

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
