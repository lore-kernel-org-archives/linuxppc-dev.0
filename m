Message-Id: <v03130309b31330a04db4@[204.254.173.51]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 15 Mar 1999 16:56:52 -0500
To: linuxppc-dev@lists.linuxppc.org
From: fwunder@pwr.com (Fred Wunderlich)
Subject: Netatalk+asun - Strict File locks
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm using netatalk-1.4b2+asun2.1.1-C6

With certain Applications (most noteably, Acrobat Distiller) running on Mac
our NT and "watching" folders on netatalk server - it seems that file
locking is not happening. Process (Distiller) begins *before* copy is
completed.

Is there a way to enforce strict file locking with netatalk+asun??

Thanks!!

fred



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
