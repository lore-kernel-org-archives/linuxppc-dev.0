Message-ID: <3D16DEA1.8C9B3315@taikebj.com.cn>
Date: Mon, 24 Jun 2002 16:56:02 +0800
From: caokai <tk19@taikebj.com.cn>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Is the pci interrupt number fixed?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all:
  I have a mpc8245 board with an internel intel 82559er ethernet adapter
.
  I am tring to porting 2.4.17 linux(Montavista Linux 2.1) on this
board. I met a thing that I can't understand.Why my ethernet adapter can
only use a interrupt 18 (assign in arch/ppc/platforms/sandpoint_pci.c)?
Anything else interrupt number can't work on this board.Is it normal?
   Can sombody give me some advice?
regards
caokai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
