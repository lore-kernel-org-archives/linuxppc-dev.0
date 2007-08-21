Return-Path: <computer-service@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7E64FDDECB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 22:19:53 +1000 (EST)
Message-ID: <46CAD865.3030107@gmx.de>
Date: Tue, 21 Aug 2007 14:19:49 +0200
From: Computer - Service <computer-service@gmx.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Linux 2.6.23.rc3 boot issues  on XUPV2P
References: <46CAC89F.2040100@genesi-usa.com> <46CACAAE.5000304@genesi-usa.com>
	<20070821113232.GB1111@localhost.localdomain>
In-Reply-To: <20070821113232.GB1111@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all.

I try to port Linux 2.6 on my XUPV2P Board which is based on ML300.

It runs sometimes, but for the usual case it just doesn't.
My problem is the initialization.
I have no clue why I get different values almost every time.
This is a log from the same zImage.elf, which is just loaded certain 
times in the row:

loaded at:     00400000 005331A0
board data at: 0000000E 0000008A
relocated to:  00404084 00404100
zimage at:     00404EB9 00530A50
avail ram:     00534000 3B784800

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel

loaded at:     00400000 005331A0
board data at: 00000000 0000007C
relocated to:  00404084 00404100
zimage at:     00404EB9 00530A50
avail ram:     00534000 7C9E2378

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel

loaded at:     00400000 005331A0
board data at: 40000000 4000007C
relocated to:  00404084 00404100
zimage at:     00404EB9 00530A50
avail ram:     00534000 00000000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...oops... out of memory
pause

loaded at:     00400000 005331A0
board data at: 00000001 0000007D
relocated to:  00404084 00404100
zimage at:     00404EB9 00530A50
avail ram:     00534000 9E23787C

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.23-rc3 (warkentin@iss2) (gcc version 
4.1.1) #1                                          Tue Aug 21 14:01:45 
CEST 2007
[    0.000000] Xilinx ML300 Reference System (Virtex-II Pro)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->   196608


and just if the "avial ram" is about 10000000 it boots.

Anyone some idea why it could happens?
