Message-Id: <v04003a03b315cd6d0f6a@[205.161.35.44]>
In-Reply-To: <36EFCF5D.8892052A@nc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 17 Mar 1999 16:23:35 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Douglas Godfrey <dvdoug@tiac.net>
Subject: Re: L2CR for upgrade cards.
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Make a copy of your Mac OS Cache enable INIT and change the type to "scri"
and rename it to load before the BootX INIT. When BootX gets control the
L2 cache will already be enabled.

Reoly to Rick Meier, 3/17/99 8:50 AM -0700: L2CR for upgrade cards.
>Has anyone actually seen the a G3 upgrade card working with the backside
>cache under LinuxPPC?  I have tried a NewerTECH G3/300 w/512k and a
>PowerLogix 400/200.  I was never able to get the cache working.  I am
>using BootX 1.0.2 and kernel 2.2.4 (checked out from vger).  I never see
>the "override" statement in my dmesg and when I look at
>/proc/sys/kernel/l2cr is shows the cache disabled.
>
>Any Ideas?

Thanx...
  Doug



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
