Date: Mon, 20 Dec 1999 14:29:59 -0500 (EST)
From: James Simmons <jsimmons@edgeglobal.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC kernel bug. (fwd)
Message-ID: <Pine.LNX.4.20.9912201428210.7400-100000@imperial.edgeglobal.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Geert I know you work with the PowerPC people. I don't belong to the list
so it might not go threw. So could you post it as well.

Subject: PowerPC kernel bug.
Date:    Mon, 13 Dec 1999 22:03:26 -0500 (EST)
From:    James Simmons <jsimmons@edgeglobal.com>
To:      GLX mailing list <glx-dev@lists.openprojects.net>, FrameBuffer List
<linux-fbdev@vuser.vu.union.edu>, Linux Kernel Mailing List
<linux-kernel@vger.rutgers.edu>


This message is toward the Fbdev/kernel group to fix this bug but I wanted
to let the GLX group what caused the memset problem on PowerPC. On a
PowerPC when you mmap the framebuffer and use memset on the mmapped
image you get a SIGBUS. Thanks Marcus for finding out what was causing the
problem.

>I noticed today that it's actually a bug in the PPC-kernel. The
>specification for the dcbz (data cache block zero) instruction
>states that for uncached memory the exception handler should clear
>the memory, but on Linux it just causes a SIGBUS to be sent to the
>app...
-----------
==============


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
