Message-ID: <19990524072457.B26885@radicalmedia.com>
Date: Mon, 24 May 1999 07:24:57 -0400
From: Mark Abene <phiber@radicalmedia.com>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: 7200/platinum with 2.2.7 kernel...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't know if anyone has noticed, but as of 2.2.7 (which is what I just 
checked), the platinum video driver still has the annoying line about three
inches above the bottom of the screen, from the middle to the right edge.
This is in modes 19 and 20 at 16bpp, (with the "scale" hack to fix the 
colormap).  The line was there without the scale-hack, so that's not it.
I was about to start digging in platinumfb.c to see what the deal is (it's
changed quite a bit), and unfortunately the first thing I noticed was that
my name was removed from the opening comments(!).  Rather uncool.  That driver
and it's header file are still chock-full of a lot of my code, and even my
comments.  I spent a good deal of time helping Paul M. get that driver working,
and am confused as to why its current maintainer saw fit to expunge my name.
Besides which, it looks like a few things were broken when it was "rewritten"
for fbconsole-style support, which makes me uneasy, since it originally worked
fine, and as expected.  I know there's a lot of focus on the G3 machines now,
but I'm sure there're still a decent number of us 7200/8200/PT120 users out
there who give a damn.  I'll look into the current problems which I'm seeing
on the list, and I'd welcome anyone's input who's messed with the driver in
its current state.  Remember, 601 users are people too.

Thanks,
-Mark


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
