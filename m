MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: kernel hangs at my_console_write
Date: Mon, 6 Aug 2001 11:48:41 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B5063408@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Elan Feingold" <elan@nxnetworks.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I dont think I use embed_config since I use the binary kernel
(vmlinux.gz). I dont use zImage. PPCBoot passes all this info to the
kernel.

But I guess, there are still places in the kernel where it expects Mhz.
By some parts in the kernel, due you mean somewhere in the uart.c init
code?

Thank you,
Navin.

-----Original Message-----
From: Elan Feingold [mailto:elan@nxnetworks.com]
Sent: Monday, August 06, 2001 11:37 AM
To: Linuxppc-Embedded (E-mail)
Subject: RE: kernel hangs at my_console_write



> I am using the Hardhat 1.2 kernel from MVista on my custom board with
> MPC855T. The kernel executes and hangs at my_console_write routine.

We were using a slightly different kernel (2.4.5 + patches), but we saw
a
hang in console_write when we didn't have our Baud Rate Generator clock
frequency correct.  In the version we were using, the numbers in
embed_config() seemed to indicate that Hz were desired, but after
grepping
around, we saw that some parts of the kernel wanted Mhz.  Once we fixed
that, we got console output and things worked.

Hope this helps,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
