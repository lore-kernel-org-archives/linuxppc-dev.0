Date: Tue, 30 Nov 1999 20:46:05 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Jon Howell <jonh@cs.dartmouth.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: installer default inode count
In-Reply-To: <Pine.GSO.3.96.991130201013.24058E-100000@sitka.cs.dartmouth.edu>
Message-ID: <Pine.LNX.3.96L.991130204522.3139L-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Nov 1999, Jon Howell wrote:
> 
> I recently installed LinuxPPC 1999 Q3, and today I ran out of inodes.
> My 3G disk is only 67% full. It turns out my inode ratio is about
> one inode per 32KB. The default for mk2efs is 4KB (-i 4096).
> 32KB seems extreme. Indeed, I see from the mailing list archive
> that someone else ran into the same problem in September
> (http://lists.linuxppc.org/listarcs/linuxppc-dev/199911/msg00047.html).
> 
> Hollis' reply hints that the installer does this on purpose, but
> I couldn't tell for sure. Could whoever maintains the installer look
> into changing the inode ratio to something lower, or is the 32KB ratio
> intentional (but unfortunate)?

I don't suppose you used a more recent installer than what's on the CD? It's a
known problem, but obviously once it's on the CD all we can do is post updates
online...

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
