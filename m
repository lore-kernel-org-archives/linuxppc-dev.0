Message-Id: <v03010d01b3198378b3d0@[209.96.179.143]>
In-Reply-To: <199903182331.KAA23199@tango.anu.edu.au>
References: <19990319001614.001351@mail.mipsys.com> (message from Benjamin
 Herrenschmidt on Fri, 19 Mar 1999 00:16:14 +0100)
 <19990319001614.001351@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 20 Mar 1999 12:02:05 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: egcs 1.1.2 big improvement over egcs 1.1.1 !
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To Franz Sirl, Gary Thomas, and Anyone else involved with egcs development
on LinuxPPC,

THANK YOU!

I just finished recompiling the JDK 1.2 with Gary's egcs 1.1.2 rpm and for
the first time since egcs 1.0-2e, a build of the JDK will actually work
without much fuss.  None of the egcs 1.1 or 1.1.1 rpms was ever able to
perform this feat without having lots of silent compiler errors which were
next to impossible to track down.

THANK YOU!   THANK YOU!

If any of you are having trouble with projects compiled with egcs 1.1.1, I
highly recommend trying egcs 1.1.2.  The only problems I have found with it
are that the haifa scheduler sometimes changes the sequence enough to mess
up monitor/lock and unlock code but that can be worked around by not using
haifa for those files.

egcs 1.1.2 is a definite improvement!

Kevin



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
