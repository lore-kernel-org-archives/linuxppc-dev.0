From: Graf Alex <alex.graf@siemens.com>
To: "'Lokesh Kumar'" <lokesh.kumar@wrx-us.com>,
	linuxppc-embedded@lists.linuxppc.org
Message-ID: <791B3205DB661A42B4BFE5464A7D1D02010E464A@chzugexch01.abatos.com>
Subject: AW: mic2563 dual slot pcmcia controller
Date: Fri, 29 Aug 2003 08:54:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
