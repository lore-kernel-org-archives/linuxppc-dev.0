Subject: How Can The Starting Address Of An Image In ELF File BeChanged
To: uclinux-dev@uclinux.org, linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFD40F49BF.D7A17B63-ON65256E4E.00170A96@lntinfotech.com>
From: "Thamarai Selvan" <Thamarai.Selvan@lntinfotech.com>
Date: Fri, 5 Mar 2004 09:48:41 +0530
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I created the elf file of the kernel using "make vmlinux", when i checked
the created system.map i found the the kernel image starting from
0xc0000000. Can any tell where this address is defined or configured? and
how can this be changed to 0x0000000 is it possible?

with regards
Thamarai Selvan.G


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
