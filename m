Date: Wed, 9 Dec 1998 12:34:25 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Cross compiling kernels.
Message-ID: <Pine.LNX.3.96.981209121231.12326B-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I'm currently trying to build a cross compiler (hosted on x86) for
building PPC kernels to run on a single board computer with an MPC850
processor.  I've read a bunch of docs, built the cross compiler from
3 different source trees, and looked at a _bunch_ of kernel stuff (docs
and code). I still have a few unanswered questions:

1) What kernel version is recommended to run the MPC8xx processors?  I've
seen references to 2.1.129, but I'm not sure.

2) What compiler/binutils packages are considered 'best' for this?
The latest I've tried is binutils-2.9.1 and egcs 1.1b

3) Is there a recommended kernel release for running with the MPC8xx
processors?  i.e. on the Moto MBX boards?

TIA,
Mark


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
