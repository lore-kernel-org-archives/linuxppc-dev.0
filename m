Message-ID: <051301c01160$d5e0b560$1952df8d@SOYANG>
From: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial 
Date: Tue, 29 Aug 2000 11:28:36 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="EUC-KR"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

I'm using 8xxrom-0.3.0 for boot loader and MVista-2.2.13 for kernel.
I tried to remove serial driver for some reason.

I have 4 questions abou it.

0. If I remove it, will board boot correctly?
1. Can I expect some performance gain with removal?
2. Are there any easy way to do it?
3. Where is most proper location for doing it? 8xxrom, m8xx_tty.c at mbxboot, or uart.c at 8xx_io?

Thanks in advance.

Have a nice day.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
