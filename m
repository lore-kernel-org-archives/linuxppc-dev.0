Date: Mon, 07 May 2001 16:09:29 -0700
From: "Conyers, Steve" <steve.conyers@lmco.com>
Subject: Would like to upgrade from 2.2.17 to 2.4 or 2.5
To: "'cort@fsmlabs.com'" <cort@fsmlabs.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <64AFDC09F27AD411BA9500508BDF7E3069E2F9@emss08m04.ems.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort --

Would be happy to upgrade from 2.2.17.  Using it (temporarily) cuz we got a
patch to it from Motorola that "might work" with the MVME5100 board.  One of
your associates (Matt Porter) has indicated that a more mature linuxppc
already patched for MVME5100 and tested somewhat is under Bitkeeper as
version 2.5.  For various reasons, we can't install Bitkeeper here, so we
have been pressing on with 2.2.17 with patches and hacks per our
correspondence.  This is how far we get with 2.2.17:

PPC6-Bug>nbo
Network Booting from: I82559, Controller 0, Device 0
Device Name: /pci@fe000000/pci8086,1209@e,0:0,0
Loading: zImage

Client IP Address      = 129.86.32.72
Server IP Address      = 129.86.32.70
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = zImage
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&468114, Bytes Loaded =&468114
Bytes/Second   =&468114, Elapsed Time =1 Second(s)

Residual-Data Located at: $03F9077C
loaded at:     00005400 0001C220
relocated to:  00800000 00816E20
board data at: 03F9077C 03F97188
relocated to:  00810314 00816D20
zimage at:     00010400 0007580F
relocated to:  00817000 0087C40F
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda2
Uncompressing Linux...done.
Now booting the kernel

Not bad, but if 2.5 (with the MVME5100 fixes) were available via FTP, I
think we would get much further.  I notice that your ftp site has
linuxppc_2_4.snap.tar.gz.  Is this what you recommend?

Steve Conyers


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
