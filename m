Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem in booting kernel
Date: Sat, 14 Jun 2003 10:13:12 +0530
Cc: j.rakesh@gdatech.co.in
MIME-Version: 1.0
Message-ID: <1iiwzz6cccr670f.140620031003@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I am working on custom design board based on IBM405 PPC. I am using OpenBios
code and Linux -2.4.17 version from montavista. I am downloading the os image
using serial port. After downoading the image, I am getting the follwoinbg
messeges:


=========================================================================


Loaded successfully ...
Entry point at 0x500000 ...

loaded at:     00500000 005AD1F8
relocated to:  00400000 004AD1F8
board data at: 004AA128 004AA168
relocated to:  00405544 00405584
zimage at:     00405BA0 004A9671
avail ram:     004AE000 04000000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...

opps... out of memory
pause
opps... out of memory
pause
opps... out of memory
pause
opps... out of memory
pause
opps... out of memory
pause
opps... out of memory
pause
opps... out of memory
pause
opps... out of memory
pause
opps... out of memory
pause
opps... out of memory
pause
done.
Now booting the kernel
========================================================================

And after this it stops.

Can anyone suggest me how to resolve this problem. I am using 4MB flash. And
Single SDRAM with single bank  of size 32MB. Can anyone helpme out to sort
out this issue.

Thanks & Regards,

rakesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
