Message-ID: <20010211043822.8854.qmail@kunk.jriver.com>
Subject: Re: BMAC stuff - what I have
To: linuxppc-dev@lists.linuxppc.org
Date: Sat, 10 Feb 2001 22:38:22 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-- forwarded message --

Kernel version: any (2.2.x - 2.4.x)

Symptoms: high speed transfers from a macintosh with a BMAC network device are limited to less than 100kB/s and often corrupted.  Systems known to have this are some Wallstreets and beige Desktops.  10/100 chips in Lombard are BMAC+ which do not seem to have the bug.  This is a hardware bug that exists in some releases of the chip, and only effects Tx packets.

-- end of forwarded message --


I see the same problem on my Rev C iMac at 100 mb in both 2.2 and 2.4
kernels. I get slow transfers and broken scp's but not corrupted
data on complete transfers. Same machine works fine in MacOS and OSX.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
