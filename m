From: John Buswell <johnb@one.net>
To: anthony tong <atong@uiuc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: iMac DV and aty128fb
In-Reply-To: <Pine.LNX.3.96.1000108181304.23736A-100000@shell>
Message-ID: <Pine.LNX.3.96.1000108191613.23736F-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Sat, 8 Jan 2000 14:19:59 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 8 Jan 2000, John Buswell wrote:

> is there any place that documents what parameters I can pass to the kernel
> with video= ? 

The display works fine in regular frame buffer mode (eg.
video=offb:ofonly). One thing I left out, aside from the video scew, in
both text and X modes, there is about an inch on the right hand side that
is black in console or white in X where the display is just not there
(mouse pointer disappears if you move it into that region), it looks like
the display is just cut off..

in text mode, the text just disappears :)

is this something that could be fixed by tweaking fbset options or
something that needs to be fixed in the ati128fb driver?

thanks


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
