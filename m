Message-ID: <37E5B2EA.9C266862@netx4.com>
Date: Mon, 20 Sep 1999 00:07:06 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Claude Robitaille <crobitaille@videotron.ca>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling 2.3.18
References: <Pine.LNX.4.10.9909191611110.1836-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Claude Robitaille wrote:

> I have no success at compiling (actually just doing make dep) the
> 2.3.18 kernel source I downloaded from linuxppc.cs.nmt.edu...

I'll download it and take a look, although this is now out
of date with the CVS tree.

> I downloaded 2.3.18 from edge.kernelnotes.org and I am able to compile
> (after fixing one of the Config.in file).

This looks like a mirror, so it is likely up to date.  What
was the problem with Config.in?

> Could it be a problem with Dave's tar (as for fadsrom.tar)?

I don't understand why some people have problems with this file.
I continually download and extract it just fine on any of my
Linux machines.  What are you using?


> I am targetting a board with an MPC8xx, does the source from the
> embedded tree at linuxppc.cs.nmt.edu better....

I usually put something there as a convenience for people that
can't get CVS access through a fire wall.  It represents my
source tree, which is known to build, just before I make CVS commits.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
