Date: Thu, 6 May 1999 13:51:13 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
cc: John L Grantham <jgrantha@hannover.sgh-net.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Partitions > 2GB?
In-Reply-To: <3731824C.3600@post.uni-bielefeld.de>
Message-ID: <Pine.LNX.3.96.990506134907.9670B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 6 May 1999, Jens Ch. Restemeier wrote:

> 
> Hi !
> 
> > It at least _used_ to be so that the various PPC Linuxen couldn't handle
> > partitions larger than 2 GB. Is that still the case as of LinuxPPC R4 and
> > newer?
> 
> I don't know where rumors like that come from... I'm running LinuxPPC on
> a 5 GB partition of a 10 GB IBM harddisk...

Not just a rumor.  It was true at one time for LinuxPPC.  I _think_ it's
still the case under MkLinux, so keeping partitions under 2 gigs is a good
idea if you're planning on using both OSes.


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
