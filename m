Message-ID: <3936F0F2.DDA90328@embeddededge.com>
Date: Thu, 01 Jun 2000 19:25:38 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Tarr <tarr@lucent.com>
CC: LINUX-PPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Motorola MPC8260-ADS Boot hassel
References: <3936790D.9BD7680E@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Tarr wrote:

I haven't tried ramdisks recently......


> RAMDISK: Compressed image found at block 0
> NIP: C0010D90 XER: 20000000 LR: C0010D8C REGS: c085f260 TRAP: 0300

What function is this (0xc0010d90)?  It is hard to help without some
basic information like this.



> GPR08: C085E000 C0008540 00000000 C085F358 00000000 FFFFFFFF 00000000
> 00000400

> Kernel panic: kernel access of bad area pc c0010d90 lr c0010d8c address
> 3C tsk 1Rebooting in 180 seconds..
>
> Based on my simple attempts it appears that I am taking a DSI exception
> on an access to
> 0xC010000......

How did you determine this?  The panic message prints the faulting
address, which happens to be 0x3c.  GPR8, 9, 10, 11, and 12 are typical
sources for intermediate pointers, two of those are zero.  I would
guess a NULL pointer to a data structure trying to access the contents
at offset 0x3c.

> I noticed in System.map that data does not the first data entry.....

Next time notice and tell us the function at NIP....much more useful.

> Note: they put the SUNI-Lite and board registers at
> 0x04500000-0x04700000.

Who is they, what's a SUNI-Lite, and does it matter?  Best of all,
if you don't like the address you can change it.


We need more info.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
