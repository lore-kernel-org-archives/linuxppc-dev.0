Date: Sun, 07 Feb 1999 22:09:01 -0500
From: Beecher Greenman <rbg6038@ritvax.isc.rit.edu>
Subject: A different Window Maker problem
To: linuxppc-dev@lists.linuxppc.org
Message-id: <01J7H7PIJZ9EA3CISC@ritvax.isc.rit.edu>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Recently I tried to install XFree86 on my R4 system. I downloaded the 
3.3.3.1 binaries from ftp.xfree86.org, and everything installed fine. 
However, now Window Maker refuses to start. WHen it tries, it complains 
about an error in the shared libs...

wmaker:error in loading share libraries
: undefined symbol _Xsetlocale

No indication of what library to use or anything. A recompile did not 
appear to solve the problem. Other windowmanagers compile and run fine. I 
haven't even run into the FD_ZERO bug that's currently plaguing some 
listmembers.

LinuxPPC R4, kernel 2.2.1 with appropriate sources and modules, XFree 
3.3.3.1 (unaccelerated), Window Maker 0.50.2, rev3 G3, 128 megs RAM, 128 
megs swap, 2 gig /

Thanks!

-Beecher Greenman

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
