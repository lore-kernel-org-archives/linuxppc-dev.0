Date: Mon, 16 Aug 1999 22:07:23 -0500
From: anthony tong <atong@uiuc.edu>
To: linux-fbdev@vuser.vu.union.edu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Preliminary Rage128 fb driver
Message-ID: <19990816220722.A17917@mango.aol.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


http://www.students.uiuc.edu/~atong/aty128/aty128.diff(.gz)

Diff is based off of the cvs.on.openprojects 2.2.11 tree today (8/66).

It's has been tested on PowerMacs only--the B&W's, and my PowerCenter
Pro, with the ATY,Rage128y. I'll probably do a x86 port at some
point, if someone else doesn't do it first.

Allegedly, the following are currently working:
 - mode switching (using calculated timings)
 - 8bpp and 32bpp X (using XF68_FBDev)
 - 8bpp console
 - video=aty128fb:vmode:<vmode> kernel arguments. cmode is also there, but
   I would sugguest selecting 8bpp. :)

Of course, fixes/features/finished implementations to come. Just thought
that I'd get this out there before the 2.3 feature freeze. :)

Let me know how/if this driver works, and all comments are welcome.

Thanks,
-at

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
