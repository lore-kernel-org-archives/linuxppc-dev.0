Message-ID: <01e301c034fb$fb1580e0$0a00010a@airvent.it>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA - another step...
Date: Fri, 13 Oct 2000 11:56:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I removed that outp_b instruction and i made another step to the goal. I
insert a Genius ME3000II SE card, fully supported by pcmcia on other x86
linux boxes, and the system hangs:

Starting PCMCIA services: modulesLinux PCMCIA Card Services 3.1.10
  kernel build: 2.2.14 #749 ven ott 13 10:46:33 CEST 2000
  options:  none
m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
m8xx_pcmcia: FADS using SLOT_B with IRQ 13.
 cardmgr.
sh-2.03# cardmgr[26]: starting, version is 3.1.10
cardmgr[26]: watching 1 sockets
cardmgr[26]: initializing socket 0
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
cardmgr[26]: socket 0: Melco LPC2-T Ethernet
cardmgr[26]: executing: 'insmod /lib/modules/2.2.14/net/8390.o'
cardmgr[26]: executing: 'insmod /lib/modules/2.2.14/pcmcia/pcnet_cs.o'
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e0000000 (1000)
Remapping e4000000 (1000)
Kernel panic: Kernel Mode Software FPU Emulation
Rebooting in 180 seconds..

What should i do now?

- may the pinguin b with u -

Have a nice day,
Paolo Scaffardi.
AIRVENT SAM s.p.a. - RIMINI - ITALY


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
