Message-Id: <200404201305.IAA27777@lists.linuxppc.org>
Date: Tue, 20 Apr 2004 21:03:48 +0800
From: "leo" <leo_guo@jisung.cn>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: DOC2000 unstable problem!!!
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I am porting linux to my MPC852 board, and linux now can runs ok, but it
seems that the DOC2000 is unstable! My system config as follows:

MCU: MPC852T 80M
SDRAM: 32MB
FLASH: 2MB
DOC2000: 32MB

I make a EXT2 file system on DOC2000, but sometimes, turn off the
board's power when linux is running, and then turn on the power, the
linux can't mount the root filesystem!

Could you give me some advices? And I want know between the NAND flash
and DOC, which is the better selection?

BRs!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
