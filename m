Date: Thu, 15 Apr 1999 10:15:47 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Brendan Simon <brendan@dgs.monash.edu.au>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user <linuxppc-user@lists.linuxppc.org>
Subject: Re: LinuxPPC: Which kernel source for MPC860 ?
In-Reply-To: <3715C876.49597E1A@dgs.monash.edu.au>
Message-ID: <Pine.LNX.3.96.990415101043.6235B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 15 Apr 1999, Brendan Simon wrote:

> I assume I need a C library.  Which C library is the best for my
> purposes ?  Lib5 or Lib6 ?  Do I need both ?

As a general rule, un*x kernel sources are self-contained, i.e. all
necessary library sources are included in the kernel source itself, partly
because it has to be statically linked, and partly to prevent bugs caused
by people compiling with a version of libc or whatever that doesn't match
the kernel sources.  You _might_ need some header files for types or
something (I'm not sure), but other than that....


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
