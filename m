Message-ID: <20021219001423.47019.qmail@web41207.mail.yahoo.com>
Date: Wed, 18 Dec 2002 16:14:23 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: After Uncompresseing Linux..., what's next
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <200212180101.gBI11p816867@p2.parker.boston.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I was trying to load linuxppc_2_4_devel onto my board.
It goes through the board info read, UART init and
Uncompressing the linux kernel. But after that, i do
not see any messages and board hangs.

Here is the UART output:
------------------------------------
OS Booting...

loaded at:     00400000 0060D1CC
board data at: 00000030 00000044
relocated to:  00405C24 00405C38
zimage at:     00406290 004A08FF
initrd at:     004A1000 006097CA
avail ram:     0060E000 007F8000

Linux/PPC load: console=ttyS0,9600 console=tty1 ip=on
root=/dev/xsysace/disc0/pa
rt3 rw
Uncompressing Linux...done.
Now booting the kernel
-------------------------------------------

After the last line, it hangs. I get a feeling that,
the uncompressing process is not writing in the memory
starting from 0x00000000 and, after uncompressing, it
is jumping into 0x00000000 and is not able to find
anything.

My questions are,
1. How can i make sure that, the uncompressing process
is going to start writing the data from 0x00000000.

2. How big a space this uncompressing process needs?
And also how much overall memory is required for
running linux. I just have 8MB SDRAM.

3. What is the next step in the booting process? Which
Device (eth, pci, ide, ???) Initialization?

Your help is appreciated.

thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
