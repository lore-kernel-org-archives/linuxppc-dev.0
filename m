Message-ID: <3670AF4C.23FF463D@jlc.net>
Date: Fri, 11 Dec 1998 00:36:12 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Cross compiling kernels.
References: <Pine.LNX.3.96.981209121231.12326B-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark S. Mathews wrote:

> I'm currently trying to build a cross compiler (hosted on x86) for
> building PPC kernels.....

Has anyone been successful doing this?  I get personal
e-mail almost weekly from people either using gcc 2.x.x.x,
which we all know is incorrect, or having problems building
a cross egcs.  I use only egcs tools natively on LinuxPPC
machines, so I have no suggestions other than that.


> 1) What kernel version is recommended to run the MPC8xx processors?  I've
> seen references to 2.1.129, but I'm not sure.

I found a couple of minor bugs in 2.1.129 when I build it
for the MPC8xx.  Cort said he fixed them in 2.1.130, so
I would start with the latest vger CVS sources.


> 2) What compiler/binutils packages are considered 'best' for this?
> The latest I've tried is binutils-2.9.1 and egcs 1.1b

That's it.


> 3) Is there a recommended kernel release for running with the MPC8xx
> processors?  i.e. on the Moto MBX boards?

The original port was done on the MBX860 board, so that
always seems to work.   I have recently finished some 823/850
stuff and realized the configuration needs lots of work, so
I am doing that right now.  The major changes include
moving most of the CONFIG_MBX to generic CONFIG_8xx,
uart/serial driver configuration, the Ethernet configurable
on any SCC, and boot code changes.  I have one more board
to port next week, and I will dump the changes on Cort :-).

In my spare time I am trying to port the latest USB software
to the 850.  Anyone else interested, let me know.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
