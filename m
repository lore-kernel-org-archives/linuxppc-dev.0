Message-ID: <38BD140B.A82C085B@vas-gmbh.de>
Date: Wed, 01 Mar 2000 13:58:51 +0100
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA-IDE for mpc8xx-linux-2.2.13
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to connect an IDE disk to the mpc860, on a TQM-860L Module
running linux-2.2.13.
According to Dan Malek it should be possible to use the PCMCIA port as a
simple IDE interface (as stated also in m8xx_setup.c).
When I try to compile the kernel with IDE/ATA-2 disk support, I get
'm8xx_setup.c: In function `m8xx_ide_init_hwif_ports':'
'm8xx_setup.c:418: `PCMCIA_MEM_ADDR' undeclared (first use in this
function)'.
So I guess I need some patches for port access and irq mapping,
mentioned by Dan.
Is it possible to make these patches available on the net?

tia
      Frank
--
===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49 40
238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at
http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
