Message-ID: <3DD114B7.EFA6E6CE@imc-berlin.de>
Date: Tue, 12 Nov 2002 15:48:23 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Using ioctl from with the kernel ???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I use a device driver (/dev/status_led from DENX) to manipulate some frontpanel
LEDs from user space via some ioctls.

Now I'd like to access them from the kernel space. How can I do that? AFAIK I
can't use fopen and ioctl...

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
