From: Philip.Lougher@Zarlink.Com
Subject: Re: Booting the kernel
To: linuxuser <rlinuxuser@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFDABBE86D.F36B2041-ON80256CD1.0049E83C@zarlink.com>
Date: Tue, 18 Feb 2003 13:31:06 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>On hyperterminal I could see the message "Now booting
>the kernel..."
>
>and the target is getting hanged due to panic
>condition.When debugged it is found that console
>driver is not getting initialized. To overcome this in
>init/main.c file , I called the console_init
>subroutine before printk(linux_banner). still the same
>problem persists..

Initialising the console before the Linux kernel does it, is generally not
a good idea.  The Linux kernel initialises it when it does, because things
are not sufficiently setup to do it before hand.

If you send a dump of the kernel output and the kernel panic, you should
get more help.  Without any output it's pure guess work.

Regards

Phillip Lougher




                      linuxuser
                      <rlinuxuser@yahoo.com>                 To:       linuxppc-embedded@lists.linuxppc.org
                      Sent by:                               cc:
                      owner-linuxppc-embedded@lists.l        Subject:  Booting the kernel
                      inuxppc.org


                      18-Feb-2003 01:05 PM







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
