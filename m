Date: Wed, 14 Jul 1999 12:21:48 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
Reply-To: Jeff Rugen <jrugen@primenet.com>
To: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: X runs on PReP with FBpatch. But......
In-Reply-To: <199907141454.XAA27695@mail.cc.tohoku.ac.jp>
Message-ID: <Pine.BSI.3.96.990714121017.6167A-100000@usr01.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Jul 1999, Kazunori Aoshima wrote:

> 8.Set color modes and monitor modes.
>   I set custom, and 1024x768 with 8bit and 16bit mode, 
>   with 1024x768 Hireflesh mode.

16bit mode won't work yet (at best you'll have really ugly colors, at worst,
it will be unusable).

> 9.Test mode start. If change monirtor modes for Xwindow like,
>   Push OK.
> 
> I don't know after No.9, because SCSI control.drops down and freeze
> my machine.

I have this problem with 2.2.10 even when I just let the machine sit idle
for a day.  I haven't spent the time to track it down (I've been hoping
someone more knowledgable about the SCSI system would do it first :-)  ).  I
have an old 2.2.2 that doesn't have this problem, but no longer have that
source (though I could probably get it from vger if I really wanted to).

> But, I would like to run Xbh.
> I could not run Xbh on my R5 environment before.
> How would I do to run Xbh? Were ther any patches?

I have a version of Xbh for R5 in the same place as the framebuffer patches
(though Jeff Garzik has a more complete set of patches that incorporates
what I did).  Xbh is at:

   ftp://linuxppc.cs.nmt.edu/pub/linuxppc/patches/Xbh-16bit-glibc2x/

However, I haven't had any luck running X of any sort on 2.2.10 -- the
machine locks up almost immediately when I try to move the mouse.  Gnome
executables (gnome-session, etc) give me immediate segmentation faults with
2.2.2, though Xbh works fine with that kernel.  I haven't spent the time to
see if Gnome is what's causing my problems with 2.2.10, but it is something
I should probably look at.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
