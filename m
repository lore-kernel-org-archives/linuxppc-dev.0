Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F12@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: James Don <JDon@spacebridge.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: kernel 2.4 smc1 problems ... advice please ...
Date: Sat, 14 Dec 2002 16:08:14 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Fixed ... after I changed the immr to 0xff000000 from 0x02200000 I left a
for(;;); in start_kernel ... sorry for the uneccessary post ...

Jim

-----Original Message-----
From: James Don [mailto:JDon@spacebridge.com]
Sent: Saturday, December 14, 2002 2:37 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: kernel 2.4 smc1 problems ... advice please ...


Hello,

I am cuurently trying to boot up the linux kernel using ppcboot 1.16 and the
2.4 kernel with only smc1 uart support as a start on an MPC860 FADS derived
board.

So far I have:
- ppcboot running great
- tftpboot graps my kernel puts in RAM
- bootm starts my kernel ... BUT no serial activity ...

I am using the vision ICE currently to debug the kernel start up but it has
a problem stepping through the 'rfi' etc when memory protection is running.

So currently I can only really peek at the PC and see that I am indeed
excuting kernel code.

I believe my memory map is ok:
MEM        VIRT        PHYS
RAM        0xc0000000  0x00000000
IMMR       0xff000000  0xff000000

My pc seems to get beyond start_kernel ... but I don't see the kernel banner
printed or anything ... with an ocillioscope I don't see any serial activity
at all after I exit ppcboot ...

I have check the following so far to the best of my abilities (until I get a
BDI 2000) ... and the MMU looks ok ... and my SMC port B settings are ok as
well.

Does anyone have any tips that could help me out? For some reason I think
either my MMU is not set to what I think it is ... or my SMC config has
tanked ...

Regards,
Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
