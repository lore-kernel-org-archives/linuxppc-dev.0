Return-Path: <mickael_corveller@hotmail.com>
Received: from hotmail.com (bay105-f10.bay105.hotmail.com [65.54.224.20])
	by ozlabs.org (Postfix) with ESMTP id AFD93679EB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 01:30:00 +1000 (EST)
Message-ID: <BAY105-F10857BC9DB3B958AC19C8D8EA00@phx.gbl>
From: "CORVELLER Mickael" <mickael_corveller@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Unable to boot a kernel on a MPC8560
Date: Tue, 16 May 2006 15:12:54 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Reply-To: pito50@hotmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

first of all, I am a newbie in embedded linux systems.

I'm trying to boot a board based on a MPC8560 (with a e500 core).

I'm using a RS232 console via a debug module connected to the SCC1 port of 
the 8560.

The boot loader is U-Boot.

It appears that the transfert of the kernel from the host to target is OK 
(I'm using TFTP).

Problems begin when I try to execute the kernel. The system appears to be 
frozen.

I don't know if the board is really frozen or if I have "only" lost the 
console.

I suspect that my error is situated in the load/execution addresses.

I've tried different couples of values : 0/0, 100000/100000, 10000/10000, 
200000/200000, etc...

I've also tried different file format (uImage, zImage.elf, zImage.s ...)

I've tried two distributions : ELINOS and DENX.

I don't know what's happened because I lose the console .

Here is the result of one of my tests :
-> niot 0
Client IP Address (0 for unknown)       = 192.168.001.126 ?
Client address mask (0 for unknown)     = 255.255.255.000 ?
Server IP Address (0 for unknown)       = 192.168.001.127 ?
File Format S(rec)/I(ntel)/B(in)/E(lf)  = B ? e
Boot File Name    (NULL for unknown)    = pimage ? zimage.elf
Boot File Load address                  = 80000 ? 0
Boot File Execution address             = 80000 ? 100000
Data update in progress...
-> nbo 0
Initialize ETH 0 in progress...
Physical link is up at 100f.

TFTP parameters :
Client IP Address               192.168.001.126
Server IP Address               192.168.001.127
Boot File Format                E
Boot File Name                  zimage.elf
Boot File Load address          0
Boot File Execution address     100000
TFTP load in progress...
Packets :     2065
ELF information :
Loading  .text         @ 0x00800000 :    18620 bytes
Loading  .data         @ 0x00805000 :   966656 bytes
Clearing .bss          @ 0x008F1000 :     8500 bytes
Bytes received = 1057082, Bytes loaded = 0
Low address = 800000, High address = 7FFFFF

After that, the console is died !

I could use some help in trying to understand what's going on.

Regards,
Mickaël
