Message-ID: <3EABDFFA.3050301@tataelxsi.co.in>
Date: Sun, 27 Apr 2003 19:19:46 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Reply-To: Kamalesh B <kamal@tataelxsi.co.in>,
	Sriram Narasimhan <nsri@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Wierd RAM configration issues - MPC8260
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Hardware : Custom Board (based on MPC8260)
Kernel: 2.4.1
PPCBoot: PPCBoot - 2.0.0 (modified for our custom board)

The board has 64MB RAM. (Micron - MT48LC8M16A2TG75)
[ 4 - 2MB SDRAM -  of  16 (bits) connected in parallel to make
8MBx64bits configuration]
[ Each SDRAM having four banks]

The board is booting up when we use only 8 MB out of the 64 MB.
(We tried both NFS boot and RAM disk boot).
The board is failing to come up for any memory configuration greater
than 8MB.

The same kernel image is working fine on MPC8260 ADS reference board,
which has a 16 MB SDRAM.
(Both NFS boot and RAM disk boot).

Any suggestions as to why it should fail to boot up with memory
configuration greater than 8MB?
We changed the following between the ADS board and our custom board (wrt
Memory Configuration only)
* Option Register - 0xFC0028C0
* Base Register - 0x00000041
* PSDMR Register - 0x414DA462
(All above configuration done in PPC Boot).
Are we missing out any configurations?

We did a read / write on the entire memory range from PPCBoot and it
worked fine. (Test Passed).
Can we do some other memory test to ensure that there are no hardware
failures ?

Any clues or suggestions would be very helpful.

Thank you.
Regards,
Sriram & Kamalesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
