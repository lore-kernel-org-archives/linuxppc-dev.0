Date: Fri, 5 Mar 1999 11:45:23 +0100 (MET)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Michael Meissner <meissner@tiktok.cygnus.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <19990304182203.A1856@tiktok.cygnus.com>
Message-ID: <Pine.SO4.4.05.9903051140350.16052-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 Mar 1999, Michael Meissner wrote:

> On Thu, Mar 04, 1999 at 08:51:55PM +0100, Gerd Knorr wrote:
> > 
> > > My final question : our board now finally boots, it can mount an
> > > NFS partition as root fs, but does anybody know where on the Internet
> > > I can find a file system tree with the binaries for LinuxPPC ? I mean,
> > > like Slackware, but for LinuxPPC. (We have no other [spare] PPC based
> > > machines, so I need a full binary file tree to set up on the NFS fs).
> > 
> > Just download the basic rpm's and install them on the NFS Server
> > with "rpm --root=/export/nfsroot4ppc -i *.rpm".
> 
> I think the point is that the normal rpm's (ie, ftp.linuxppc.{org,com}) won't
> work too well on an ppc860, since that machine does not have a FPU, and the
> kernel support for emulating fp might not be present or even if present, too
> slow.

 Mmmh, our board, an MVME2306 has a PPC604, so I don't see a problem
 there.

> One thought is to build a cross compiler on some other system, and manually
> build the compiler and enough tools to run native and then bootstrap the old
> fashioned way (you probably want to use the --with-cpu=860 switch when
> configuring, so that binaries by default don't reference the fpu).  However,
> setting up a cross compiler is somewhat tricky if you've never done it before.

 I did build a cross-gcc and cross-binutils, and yes, this is *extremely*
 tricky. The docs are little bit too sparse on how to _correctly_ build
 the cross-tools. Anyway, my first attempts to build a PPC kernel from
 the standard Linux source tree failed. So I really want a native gcc
 on the board...

 Regards,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"Orcs are not exactly known for their valor - although
 most Orcs have seen countless battles, only a handful 
 have actually fought in them."
 - 'Orcish Veteran' (M:TG)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
