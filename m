Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem in booting the linux
Date: Sat, 14 Jun 2003 17:50:45 +0530
Cc: j.murali@gdatech.co.in
MIME-Version: 1.0
Message-ID: <m0dyxsp45bf38fp.140620031740@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I am working on custom design board based on IBM405 PPC. I am using OpenBios
code and Linux -2.4.17 version from montavista. I am downloading the os image
using serial port. After downoading the image, I am getting the follwoinbg
messeges:

============================================

.............
opps... out of memory
pause
opps... out of memory
pause
done.
Now booting the kernel
========================================================================

And after this it stops.

In the openbios bootcode we r initializing the

RAM_BANK_0		0x02000000   (address)
RAM_BANK_0_SIZE       0x00000000

RAM_BANK_1		0x00000000   (address)
RAM_BANK_1_SIZE       0x02000000

We r not using the RAM_BANK_0 in the bootcode.

we think when loading the kernel it is taking the size of RAM_BANK_0


Can anyone suggest me how to resolve this problem. I am using 4MB flash.
We have connected 32 MB of sdram in sdram_controller_0 and we have
disable sdram_controller_1.

Can anyone helpme out to sort  out this issue.

Thanks & Regards,

rakesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
