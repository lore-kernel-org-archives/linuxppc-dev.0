Message-ID: <20030218130534.84915.qmail@web20710.mail.yahoo.com>
Date: Tue, 18 Feb 2003 05:05:34 -0800 (PST)
From: linuxuser <rlinuxuser@yahoo.com>
Subject: Booting the kernel
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am trying to port linux (ELDK 1.0.1) on custom
MPC860 target board and new to this work. I am facing
problems at particular stage.

On hyperterminal I could see the message "Now booting
the kernel..."

and the target is getting hanged due to panic
condition.When debugged it is found that console
driver is not getting initialized. To overcome this in
init/main.c file , I called the console_init
subroutine before printk(linux_banner). still the same
problem persists.. Is this problem is due to MMU
initialization ??
On target board we have 2MB Flash memory( addr
0x2800000-29FFFFF)and 32 MB SD RAM with starting
address 0x0000000.

I followed the following steps to compile and using
SDS debugger
make menuconfig,make dep, make zImage

If any one have solution kindly reply ..

shekar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
