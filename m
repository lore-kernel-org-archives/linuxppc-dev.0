Message-ID: <20030402013434.7201.qmail@web21010.mail.yahoo.com>
Date: Tue, 1 Apr 2003 17:34:34 -0800 (PST)
From: kas turi <inox_kas@yahoo.com>
Subject: Disabling data cache
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
  We have a custom made board and we are running 8250
processor. We are using DMA to transmit and receive
data between peripheral and memory. The data is
getting corrupted while transmitting and receiving. We
are suspecting it might be due to data cache being
enabled. So I disabled data cache in the routine
enable_cache in the file arch/ppc/kernel/head.S. I
rebuilt the kernel and when I run on my board it hangs
after printing "Now booting the kernel". I would like
to know why the kernel is not booting up. I have
enclosed the console output:

Transfering control to linux (at address 00400040)
loaded at : 00400040   0040b340
relocated to : 00400000 0040b300
board data at: 007FFE40 007FFEF8
relocated to: 0040B148  0040B200
image at:     0040B340  004B6026
avail ram:    004B7000  04000000

Linux/PPC load: console=ttyS0,9600
root=/dev/mtdblock/1
Uncompressing linux
Now booting the kernel

Also I would like to understand what is the use of ESE
bit in SIUMCR. Should this bit be always enabled
whenever data cache is enabled.

Any help is appreciated.

Yahoo! Tax Center - File online, calculators, forms, and more
http://platinum.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
