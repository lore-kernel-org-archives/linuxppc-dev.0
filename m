Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux-2.4.18 on MPC860T -Linux kernel boot problem
Message-ID: <1052744877.3ebf9cad5d4d8@pop-mail.india.tejasnetworks.com>
Date: Mon, 12 May 2003 18:37:57 +0500 (IST)
From: Anil Giri <anil@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

I'm trying to run a Linux kernel (2.4.18) on a Motorola MPC860T
processor.But my kernel boot hangs in my_console_write function in uart.c
I can't see any message on the console after "Now booting the kernel".

My question is, has anyone been able to boot a 2.4.18 kernel on an
MPC860T, using PPCBoot as the boot loader ? If so, have you encountered such a
problem ? Is there any issue with clock freq. in Hz instead of Mhz.?
Is there any patch available for ppc?

Following is the output on console...
=========================================

Initializing...
  CPU:   XPC860xxZPnnD4 at 66 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
  Board:  103-PCALTC101-E  AF-4402-20-0041
  Ethernet Address : 00:04:95:05:00:0e
   1/ 2/ 0  3: 7:25
  DRAM:  (128 MB SDRAM) 128 MB
  FLASH: 16 MB
*** Warning - bad CRC, using default environment

  Input:  serial
  Output: serial

Hit any key to stop autoboot:  0
## Starting application at 0x40080000 ...
loaded at:     40080000 40089368
relocated to:  00180000 00189368
board data at: 07F3FE48 07F40000
relocated to:  00200100 002002B8
zimage at:     40086000 4010A956
initrd at:     4010A956 40360A1A
relocated to:  07DA9000 07FFF0C4
avail ram:     00201000 07DA9000

Linux/PPC load: root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
=========================================

-Anil


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
