Date: Tue, 13 Apr 1999 18:32:06 +0200 (METDST)
From: Niels Roest <N.P.Roest@ITS.TUDelft.NL>
Subject: Re: ggi and frame buffer
In-reply-to: <Pine.LNX.4.10.9904122007520.23848-100000@beer.pub.umich.edu>
To: satadru pramanik <satadru@umich.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.HPP.3.95.990413182812.17396A-100000@elektron.et.tudelft.nl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 12 Apr 1999, satadru pramanik wrote:

> 
> Since linuxppc defaults to using a FB-device, ggi should work, right?  So
> I compiled the latest snapshit, and when I tried to run a demo, ie
> "cube3d" I got this:
> cube3d: error in loading shared libraries: /usr/local/lib/libgg.so.0:
> R_PPC_REL2
> 4 relocation out of range
> 
> Any clues to what this is?  Has anybody gotten libgii and libggi to work
> successfully on LinuxPPC, especially pre-rel5?
> 
> 
I did compile it on pre-rel5, the one with libc-2.0.108, and kernel 2.2.1,
on an 7600 (that's with a control chip if that matters)
It was a while ago, I rm-ed the sources, but I tried
it on linux-heretic (I compiled both xheretic and ggiheretic)
and it still works ok. Note: this is not on console, but in X.
I didn't try it in console. so ggi on X works.
Niels


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
