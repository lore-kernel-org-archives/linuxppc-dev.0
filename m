Message-ID: <00e801c3c3a1$c0a00790$4844900a@hydingnb1>
From: "hyding" <nari_dhy@nari-china.com>
To: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
Subject: port u-boot to ML300 board
Date: Tue, 16 Dec 2003 14:56:38 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
    At first,forgive I post this mail here.But i can't send a
confirmation to the u-boot-users-request@lists.sourceforge.net list at
this moment.
    I want to to port u-boot-1.0.0 to ml300 board,give me some hints
please.
    Ml300 board shows SOC design in a Virtex-II-pro. It has an IBM
microdrive harddis)k instead of flash.I think u-boot needn't to
initialize SDRAM controller(right?).I plan to port u-boot-1.0.0 by the
following steps:
1)add a board dir and config,source files associated
2)make u-boot
3)combine u-boot and FPGA bitstream into .ace file
4)configure FPGA with .ace file
5)u-boot provide some functions such as, monitor,shell,tftp,loads,etc
6)load kernel and initrd(what to be done to make pImage?)

Thanks!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
