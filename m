Message-ID: <382333E0.1F57B795@netx4.com>
Date: Fri, 05 Nov 1999 14:45:36 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: Dan Malek <dan@penguin.netx4.com>, linuxppc-embedded@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying to find out the current state of Linux on a MPC 8260
References: <m11jo7O-001SwNC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


diekema_jon wrote:


> What CVS archives do you update?

I have access to the vger CVS tree, and only update the minimal
embedded 8xx and 82xx files.  I rely heavily (and thankfully :-)
on others to ensure these changes are propagated into Linus'
and other trees.


> What are the collection names that contains the updates?  Is it just "linux"?


Yes, for the kernel.

I think it is time to remind everyone finding, compiling and booting
a kernel is actually the easy part of the development effort.  The
real challenges are the applications.....creating the development
environment with compiler, libraries, debuggers and other tools
is time consuming.  I try to make the embedded things I do work
as closely to a desktop or server as possible, but there are
sometimes differences.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
