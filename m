Message-ID: <19991130202147.20629@primate.wisc.edu>
Date: Tue, 30 Nov 1999 20:21:47 -0600
From: Paul DuBois <dubois@primate.wisc.edu>
To: Jon Howell <jonh@cs.dartmouth.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: installer default inode count
References: <Pine.GSO.3.96.991130201013.24058E-100000@sitka.cs.dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.3.96.991130201013.24058E-100000@sitka.cs.dartmouth.edu>; from Jon Howell on Tue, Nov 30, 1999 at 08:15:28PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 30, 1999 at 08:15:28PM -0500, Jon Howell wrote:
> I recently installed LinuxPPC 1999 Q3, and today I ran out of inodes.
> My 3G disk is only 67% full. It turns out my inode ratio is about
> one inode per 32KB. The default for mk2efs is 4KB (-i 4096).
> 32KB seems extreme. Indeed, I see from the mailing list archive
> that someone else ran into the same problem in September
> (http://lists.linuxppc.org/listarcs/linuxppc-dev/199911/msg00047.html).

This happened to me a couple of weeks ago, and the problem went away
when I reduced the size of the affected partition to be less than 2GB.
I assumed that perhaps some integer overflow problem occurred in
the math that computes the number of inodes, because that number
was ridiculously low.

> Hollis' reply hints that the installer does this on purpose, but
> I couldn't tell for sure. Could whoever maintains the installer look
> into changing the inode ratio to something lower, or is the 32KB ratio
> intentional (but unfortunate)?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
