Content-Type: text/plain;
  charset="us-ascii"
From: Brian Waite <waite@skycomputers.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Embedded Planet 405Gp booting
Date: Fri, 16 Aug 2002 10:23:18 -0400
MIME-Version: 1.0
Message-Id: <200208161023.18576.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
Sorry if this is stupid question, but I am trying to revive and Embedded
planet 405 GP board with Linux. Someone else got it booting and has since
lost the .config.I am trying to re-create this with little work. I am using
PPCBoot 1.1.4 and have been working with the linuxppc_2_4_devel tree (kernel
version 2.4.19-rc3. PPCboot is fine, but once it jumps into the kernel I get
nothing. Looking at the log_buf in memory it looks like it is taking a kernel
stack overflow exception. Am I just doing sometinhg  stupid? It feels like I
have a bad option or lack thereof in my .config? I am attaching it just for
fun. If anyone has a working .config for this board that would be great.

Thanks in advance.
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
