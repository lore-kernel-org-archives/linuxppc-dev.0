From: "Kapil Konde" <kapilkk@yahoo.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Loading kernel on ppcboot
Date: Thu, 4 Oct 2001 17:35:17 +0530
Message-ID: <GDEHIPAFEMJDKNFDCIEBMEJACCAA.kapilkk@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
	I am trying to load kernel using ppcboot. After I load kernel using tftp
and give bootm command I get following response.

....
....
   Data Size:    574121 Bytes = 560 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x00FBF7F0 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF00
No initrd
## Transferring control to Linux (at address 00000000) ...


	And nothing happens after this. Can somebody please explain.


Thanks and regards,
Kapilk.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
