Return-Path: <brian.hill@xilinx.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 6D7FBDDE21
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Oct 2008 06:08:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: GDB, xilinx ml50x
Date: Wed, 29 Oct 2008 13:08:27 -0600
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C06F7F572@XCO-EXCHVS1.xlnx.xilinx.com>
References: <20233115.post@talk.nabble.com>
	<689CB232690D8D4E97DA6C76DA098E6C06F7F572@XCO-EXCHVS1.xlnx.xilinx.com>
From: Brian Hill <brian.hill@xilinx.com>
To: "John Linn" <linnj@xilinx.com>,
	"Stuart Bershtein" <sbershtein@quantum3d.com>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20081029190842.86510A90066@mail29-wa4.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Stuart,
I've successfully used GDB with our GIT Linux kernel.  This was with a
root file system I'd created using buildroot
(http://buildroot.uclibc.org/).  Buildroot includes the option to build
a gdbserver ("man gdbserver" for details of how to use this application)
which can be run on the target. The XMD GDB server is most definitely
_not_ suited to debugging a Linux process.  I've used the XMD GDB server
to look at global kernel data structures and the like -- and that is
about all it could be used for.

-Brian

> -----Original Message-----
> From: John Linn
> Sent: Wednesday, October 29, 2008 1:00 PM
> To: Stuart Bershtein; linuxppc-embedded@ozlabs.org
> Cc: Brian Hill
> Subject: RE: GDB, xilinx ml50x
> =

> Hi Stuart,
> =

> Most of my work is in the kernel rather than user space, but I've used
old
> GDB versions a small amount.  I'm copying Brian as he has used it more
> than myself.
> =

> Did you get older versions of GDB to work but not the 6.8?
> =

> Did you build GDB yourself or using prebuilt?
> =

> With regards to using the eabi gdb with the EDK, my understanding (not
an
> expert) is that the Linux ABI is not the same as EABI such that you
might
> get some things to work but not all. Sorry for the fuzzy answer there.
> =

> Thanks,
> John
> =

> > -----Original Message-----
> > From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
> [mailto:linuxppc-embedded-
> > bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Stuart
Bershtein
> > Sent: Wednesday, October 29, 2008 12:32 PM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: GDB, xilinx ml50x
> >
> >
> > Hello all.  I am having difficulty getting gdb6.8 and gdbserver
> functioning
> > on a xilinx ml507 evaluation board running linux-2.6-xlnx.git.  Has
> anyone
> > done this successfully?  I can get gdb to run a small application
but
> > hitting a breakpoint (or stepping) results in a dead PPC core.
Perhaps
> > someone has had success with the Xilinx provided
powerpc-eabi-gdb.exe?
> Is
> > the this and the gdbserver built into XMD intended for debugging
linux
> > applications?  Thanks in advance for your good counsel.
> > --
> > View this message in context:
http://www.nabble.com/GDB%2C-xilinx-ml50x-
> tp20233115p20233115.html
> > Sent from the linuxppc-embedded mailing list archive at Nabble.com.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
