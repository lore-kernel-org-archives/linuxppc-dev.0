Date: Sun, 14 Oct 2001 03:44:30 -0400 (EDT)
From: Andrew P McPherson <apm@MIT.EDU>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Compiling BootX?
Message-ID: <Pine.GSO.4.30L.0110140340130.6055-100000@nerd-xing.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm attempting to port the experimental nubus-pmac kernel to 68k Macs
upgraded with a PowerPC card.  I have found that the BootX version
modified for the Nubus powermacs, avalable at nubus-pmac.sourceforge.net,
nearly works with my Quadra 700+PPC card, but that it hangs while
configuring the video.

I have a decent idea of what needs to be done to fix it, but the problem I
have is this: BootX appears to require CodeWarrior to compile.  I don't
have CodeWarrior.  I only have Apple's Project Builder tools.   So is
there any way I can compile BootX under Project Builder?  Project Builder
for OS X would be ideal, but I could use a Classic version as well.

Does anyone have a project file that would allow this, or if not, have any
idea what I would have to do to make one?

Thanks for any help.  If this is the wrong place to ask this question, I
apologize.

-Andrew


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
