Return-Path: <sbershtein@Quantum3D.com>
Received: from email-sjc.quantum3d.com (unknown [63.150.7.19])
	by ozlabs.org (Postfix) with ESMTP id 41844DDF44
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Oct 2008 08:23:34 +1100 (EST)
From: Stu Bershtein <sbershtein@Quantum3D.com>
To: John Linn <John.Linn@xilinx.com>, "linuxppc-embedded@ozlabs.org"
	<linuxppc-embedded@ozlabs.org>
Date: Wed, 29 Oct 2008 14:18:01 -0700
Subject: RE: GDB, xilinx ml50x
Message-ID: <7AA499A2BBCACB439F2C5A9BB8D2E1EBB7636B@email-sjc.quantum3d.com>
References: <20233115.post@talk.nabble.com>
	<20081029190015.439DD1528070@mail62-wa4.bigfish.com>
In-Reply-To: <20081029190015.439DD1528070@mail62-wa4.bigfish.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Brian Hill <bhill@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello John,

> Did you get older versions of GDB to work but not the 6.8?

For the server (where the problem _seems_ to lie), I just have gdbserver 6.=
8 built from sources and that's all I've ever tried.

> but I've used old GDB versions a small amount

Any idea what version?  If you have an executable that you could zip up and=
 send me I'd like to try it.

> With regards to using the eabi gdb with the EDK, my understanding (not an=
 expert) is that the Linux ABI is not the same as EABI

I've been talked out of using this in any case.  I've plenty of [--host=3Dx=
86_64-unknown-linux-gnu --target=3Dpowerpc-linux] versions of gdb (client) =
around and they all behave identically.

Thanks,
Stu




-----Original Message-----
From: John Linn [mailto:John.Linn@xilinx.com]
Sent: Wednesday, October 29, 2008 12:00 PM
To: Stu Bershtein; linuxppc-embedded@ozlabs.org
Cc: Brian Hill
Subject: RE: GDB, xilinx ml50x

Hi Stuart,

Most of my work is in the kernel rather than user space, but I've used
old GDB versions a small amount.  I'm copying Brian as he has used it
more than myself.

Did you get older versions of GDB to work but not the 6.8?

Did you build GDB yourself or using prebuilt?

With regards to using the eabi gdb with the EDK, my understanding (not
an expert) is that the Linux ABI is not the same as EABI such that you
might get some things to work but not all. Sorry for the fuzzy answer
there.

Thanks,
John

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Stuart Bershtein
> Sent: Wednesday, October 29, 2008 12:32 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: GDB, xilinx ml50x
>
>
> Hello all.  I am having difficulty getting gdb6.8 and gdbserver
functioning
> on a xilinx ml507 evaluation board running linux-2.6-xlnx.git.  Has
anyone
> done this successfully?  I can get gdb to run a small application but
> hitting a breakpoint (or stepping) results in a dead PPC core.
Perhaps
> someone has had success with the Xilinx provided powerpc-eabi-gdb.exe?
Is
> the this and the gdbserver built into XMD intended for debugging linux
> applications?  Thanks in advance for your good counsel.
> --
> View this message in context:
http://www.nabble.com/GDB%2C-xilinx-ml50x-tp20233115p20233115.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
