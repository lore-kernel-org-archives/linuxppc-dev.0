Date: Sat, 31 Jul 1999 20:03:24 -0500 (CDT)
From: Vinai <vroopcha@post.its.mcw.edu>
To: Don Lunder <speedy@carboncode.com>
cc: roikawa@rr.iij4u.or.jp, linuxppc-dev@lists.linuxppc.org
Subject: Re: C&T acceleration support, needs testers.
In-Reply-To: <199907312248.QAA05182@carboncode.com>
Message-ID: <Pine.SOL.3.96.990731195820.18111A-100000@post.its.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 31 Jul 1999, Don Lunder wrote:

}On a side note, I noticed that when I run with the video driver on the 
}2400, the first time I start X, instead of a "grey" pixely screen, it  
}has a blue hue to it, and it will seg fault, but if I try running it
}again, it starts up correctly, and goes into WindowMaker.

I had this problem with the original XF86 server, that I replaced with
the Xpmac that was posted this morning ...  It seemed that MacOS would
set the bit depth of the screen to one the XF86 could not recognize or
handle, so that is why it would be that weird colour and segfault. When
that happened, and the X-server exited, it said it was trying to set a
24-bit screen.  But the second time (when it would run correctly) it'd
say 15-bit screen.  So it looks like X set the bit depth correctly on
the first launch and was able to use it the second time.

But with the new X-server, I don't have this problem...

Cheers
vinai




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
