To: linuxppc-dev@lists.linuxppc.org
Subject: Support for Marvell's GT-64260 system controller
From: Josh Huber <huber@mclx.com>
Date: 27 Jun 2001 16:47:13 -0400
Message-ID: <87d77pbqge.fsf@mclinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Over here at Mission Critical we've been working on ports for both
ppcboot and the kernel to the GT-64260 (Discovery) system controller.

This is just a heads-up, since we're to the point of usability and
have made the sources available for download via our Open Source
Software web site:

http://oss.mclx.com/projects/marvell/

>From there you can grab the 1.0.1 version of ppcboot, Linux kernel
sources and a sample root filesystem (based on Debian GNU/Linux).  The
changes required have already made it into the stock version of
ppcboot, and I hear that the kernel source changes are on their way
in.

This code has been known to run on the Marvell Evaluation Board
(EVB-64260), modifications will (of course) be necessary to support a
custom board.

Have a nice day,

--
Josh Huber


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
