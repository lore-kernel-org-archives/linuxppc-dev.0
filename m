Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D75@norcom2.norcom.net>
From: Lokesh Kumar <lokesh.kumar@wrx-us.com>
To: Lokesh Kumar <lokesh.kumar@wrx-us.com>,
	"'Graf Alex'" <alex.graf@siemens.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mic2563 dual slot pcmcia controller
Date: Tue, 2 Sep 2003 13:49:17 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Can somebody point to a similar driver code, to control mic2563, which is
memory mapped on mpc8xx board, with cs#4 as chip select? Any template driver
code would be helpful as well.

Lokesh

-----Original Message-----
From: Lokesh Kumar
Sent: Friday, August 29, 2003 8:24 AM
To: 'Graf Alex'; Lokesh Kumar; linuxppc-embedded@lists.linuxppc.org
Subject: RE: mic2563 dual slot pcmcia controller


I have 2.4.18 kernel, and is booted by u-boot 0.4. However, I do not think
that I should do any init of pcmcia controller from the u-boot, because
u-boot does not use it and hence should not init it. I want to init it
inside the kernel. I thought m8xx_setup.c and m8xx_pcmcia.c is a better
place to do all my chip select for controlling mic2563 and the other pcmcia
related settings.

Lokesh

-----Original Message-----
From: Graf Alex [mailto:alex.graf@siemens.com]
Sent: Friday, August 29, 2003 2:55 AM
To: 'Lokesh Kumar'; linuxppc-embedded@lists.linuxppc.org
Subject: AW: mic2563 dual slot pcmcia controller


Hello

I did setup the second PCMCIA Slot on a MPC855. The bootloader (u-boot)
setups the pbrX, porX, ... registers. The kernel lives with this values.
Which Kernel do you have? For me was the /drivers/ide/ide-m8xx.c the most
important file (I needed CF support).

Cheers

Alex

-----Ursprüngliche Nachricht-----
Von: Lokesh Kumar [mailto:lokesh.kumar@wrx-us.com]
Gesendet: Donnerstag, 28. August 2003 20:45
An: linuxppc-embedded@lists.linuxppc.org
Betreff: mic2563 dual slot pcmcia controller



Hi,

I have a mpc8xx based board, which has two pcmcia slots, and uses micrel
2563a power controller. Now, I understand that I have to control this in the
file drivers/pcmcia/m8xx_setup.c file. I was wondering if anybody has done
the same and can tell me what is the right way. Also, where do I set the
other pcmcia related values for example pbr0, memory size etc? Any pointers
would be helpful.

Thanks in advance.

Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
