Date: Tue, 30 Nov 1999 21:40:51 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Paul DuBois <dubois@primate.wisc.edu>
cc: Jon Howell <jonh@cs.dartmouth.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: installer default inode count
In-Reply-To: <19991130202147.20629@primate.wisc.edu>
Message-ID: <Pine.LNX.3.96L.991130213815.3139O-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Nov 1999, Paul DuBois wrote:
> 
> On Tue, Nov 30, 1999 at 08:15:28PM -0500, Jon Howell wrote:
> > I recently installed LinuxPPC 1999 Q3, and today I ran out of inodes.
> > My 3G disk is only 67% full. It turns out my inode ratio is about
> > one inode per 32KB. The default for mk2efs is 4KB (-i 4096).
> > 32KB seems extreme. Indeed, I see from the mailing list archive
> > that someone else ran into the same problem in September
> > (http://lists.linuxppc.org/listarcs/linuxppc-dev/199911/msg00047.html).
> 
> This happened to me a couple of weeks ago, and the problem went away
> when I reduced the size of the affected partition to be less than 2GB.
> I assumed that perhaps some integer overflow problem occurred in
> the math that computes the number of inodes, because that number
> was ridiculously low.

The problem was in older X installers, which incorrectly interpreted pdisk's
output. It's since been fixed, so all users trying to install Q3 (so chances
are they'll never read this :( ) should download the new ramdisk (which
contains the newer installer) from ftp://ftp.linuxppc.org/install.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
