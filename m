Return-Path: <sithglan@stud.informatik.uni-erlangen.de>
Received: from faui03.informatik.uni-erlangen.de
	(faui03.informatik.uni-erlangen.de [131.188.30.103])
	by ozlabs.org (Postfix) with ESMTP id 8E0FCDDE39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 23:45:39 +1000 (EST)
Date: Wed, 20 Jun 2007 15:45:38 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: linuxppc-embedded@ozlabs.org
Subject: OPB vs. PLB DDR Memory Controller
Message-ID: <20070620134537.GA11302@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I used secretlabs kernel tree and build my hardware once with the obp
uart and once with the uart lite and compiled in the coresponding
drivers into the linux kernel.

        loaded at:     00400000 004951A0
        board data at: 00000000 0000007C
        relocated to:  0040402C 004040A8
        zimage at:     00404EE5 00492F1A
        avail ram:     00496000 7C9E2378

        Linux/PPC load: root=/dev/nfs rw ip=on
        Uncompressing Linux...done.
        Now booting the kernel

As you can see the embedded boot loader works, but the kernel does not
produce any output. I wonder if I have to configure Linux that it has a
OPB Memory Controller instead of a PLB Memory Controller. I used the
ml403 Option in my kernel config.

        Thomas
