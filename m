Message-ID: <3E725ACA.7080301@rettung.at>
Date: Fri, 14 Mar 2003 23:42:18 +0100
From: Guenther SOMMER <gue@rettung.at>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc on dsp-board
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi!

i'd like to start linux on a dsp-board (where no linux has gone before :)))

it's a dsp-board with some dsp on board an a motorola 860 processor. the
board itself has 32mb sdram and 8 mb flash. the board has a bootloader
integrated, which configures the mpcs and start a simple "boot-aplication".

normal vxworks is used, but it's time to start something useful now :)))

i'd like this bootapplication to start linux, but how can i do this. the
bootloader itself should stay, because it does the initialization.

i didn't find anything like ROLO (a rom-bootloader for linux, but only
for x86). ppcboot is a total overkill, because the board is complete
initalized, i only need something to start the kernel (no config, no
transfer of images, no..., only kick the kernel, which lies mapped in
memory from the flash).

the other problem is, which setting for the "board type" in the
linux-kernel itself should (kernel from ELDK at www.denx.de) be used?

hope you can give me some tips, i'd like to show my boss, that linux
runs everywhere!

greetings, guenther sommer.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
