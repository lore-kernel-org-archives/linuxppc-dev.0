From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Date: Tue, 13 Apr 1999 22:43:58 +0200
Message-Id: <199904132043.WAA01310@macintoy.masq.in-berlin.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ggi and frame buffer
In-Reply-To: <Pine.LNX.4.10.9904122007520.23848-100000@beer.pub.umich.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In lists.linuxppc.dev, you wrote:
> 
> Since linuxppc defaults to using a FB-device, ggi should work, right?  So
> I compiled the latest snapshit, and when I tried to run a demo, ie
> "cube3d" I got this:
> cube3d: error in loading shared libraries: /usr/local/lib/libgg.so.0:
> R_PPC_REL2
> 4 relocation out of range

Turning off the usage of mmap() for malloc with mallopt(M_MMAP_MAX,0)
might fix this.

  Gerd


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
