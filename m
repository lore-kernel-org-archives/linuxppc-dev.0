Message-ID: <A109131318C4D1119AC20060088DECE34B8F42@mail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: "'Joe Dery'" <jedery@mtu.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Walnut user-space software problem
Date: Tue, 13 Feb 2001 09:14:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Could this be a little Endian--big Endian problem?

Your variable size assumptions are correct.

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.


-----Original Message-----
From: Joe Dery [mailto:jedery@mtu.edu]
Sent: Tuesday, February 13, 2001 8:50 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Walnut user-space software problem



My senior design group is working with a IBM Walnut board
with the 200 MHz 405GP r3.  We have the linux kernel and
target filesystem taken from the Nov. 26, 2000 sources.
The board boots Linux from NFS flawlessly after compilation
using the CDK 1.0 8xx toolkit.

Our project objectives include  compiling the ITU-T G.723.1
(Voice over IP) standard C source code.  We are (again) using
the powerpc-linux-gcc included with the MV CDK 1.0 tools for
PowerPC 8xx-based machines.

I understand that an updated devkit is available, but since
our budget cannot touch the subscription fees needed to
obtain the MontaVista toolkit for the 405GP.

Enough background already.  The problem arises in that
when we compile the VoIP source code and run it on the
PowerPC, the output of the encoder and decoder is wrong.
When the same code is compiled for our host machine
(using i386 gcc) the output is ok.  This C code involves a
lot of speed-oriented fixed-point mathematics - that is, a lot
of multiplies and shifts (to avoid divides)  Just searching for
the >> and << operators in the kernel source doesn't bring
up much.  So to me this may be the culprit.  Sorry to make
this so vague - I am just hoping that someone has seen problems
with math/DSP oriented programs before and can suggest
something!

Also, I wanted to verify the size of the variable types in the
gcc compiler for the PowerPC.  Please correct me if I'm
wrong.

int 		- 32 bit signed integer
short	- 16 bit signed integer

I am also curious if this could be caused by the Revision C
errata.  However, I am not sure of that errata's nature or the
methods of work-around.

Thanks for any help you can provide in advance!
Joe Dery
jedery@mtu.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
