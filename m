Date: Wed, 14 Apr 1999 19:13:02 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org, bug-gnuplot@dartmouth.edu
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
In-Reply-To: <3715166A.FD1AF78F@wanadoo.fr>
Message-ID: <Pine.LNX.4.05.9904141910410.487-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 15 Apr 1999, Martin Costabel wrote:

> I think I sent this already to the LinuxPPC developers some time ago,
> but I had a look into the latest gnuplot-3.7-2.ppc.rpm, and the bug is
> still there:

Whoops.  Lost along the line.  Checked into CVS now, and may or may not
make it into the upcoming beta. (might be another full build in time,
might not).

> In principle, it would be nice if this were included in the gnuplot
> sources, but since it seems to be a ppc specific problem, it would be
> sufficient to include the patch in the gnuplot-3.7-x.src.rpm for
> LinuxPPC (Tom?). 

Hmm.  I don't use gnuplot (and thus didn't see the bug and don't have the
source handy), so if any x86/Linux users with glibc 2.1.x installed could
see if they run into the bug..

> Or could someone find out what's wrong with the fprintf function in
> LinuPPC? Note that this is not specific for one version of glibc. I
> tried it on several from glibc-961212 to glibc-2.1.1-3a. Same result.

It failed under the old libs?

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
