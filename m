Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D86@norcom2.norcom.net>
From: Lokesh Kumar <lokesh.kumar@wrx-us.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc8xx pcmcia cardmgr problem
Date: Wed, 17 Sep 2003 15:47:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Guys,

I am trying to bring pcmcia up on my mpc855 based board. I am using
kernel-2.4.18 and have pcmcia extensions.

I am making pcmcia as module, so  I can insmod pcmcia_core and m8xx_pcmcia
and ds. When I insert the card and start cardmgr, this is what I get.


Starting PCMCIA services: cardmgr[79]: watching 2 sockets
done.
cardmgr[80]: starting, version is 3.2.5
cardmgr[80]: socket 1: 350 Series Wireless LAN Adapter
# insmod: insmod: char-major-4: no module by that name found
cardmgr[80]: executing: 'modprobe airo'
cardmgr[80]: + Using /lib/modules/2.4.18/kernel/drivers/net/wireless/airo.o
cardmgr[80]: executing: 'modprobe airo_cs '
cardmgr[80]: + Using
/lib/modules/2.4.18/kernel/drivers/net/wireless/airo_cs.o
m8xx_pcmcia: voltage_set slot=B, vcc=5, vpp=5
 <7>m8xx_pcmcia: Service(1, 4, 0xc1e9180c)
m8xx_pcmcia: WRX voltage_set slot=B, vcc=5, vpp=5
 <7>m8xx_pcmcia: Service(1, 8, 0xc1e91870)
Kernel panic: request_irq
 <0>Rebooting in 180 seconds..

What am I missing here?? why is it trying to insmod char-major-4?? and why
does the kernel panic??


Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
