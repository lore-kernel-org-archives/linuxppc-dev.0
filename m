Date: Mon, 12 Jul 1999 09:02:43 +1000
Message-Id: <199907112302.JAA20812@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
Subject: media bay problems
Reply-to: Paul.Mackerras@cs.anu.edu.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The fix for the media bay problems is to change in_8 to inb in the
definition of MB_IDE_READY in mediabay.c.  I am away from home at the
moment, that's why I haven't posted a patch. :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
