Message-ID: <791B3205DB661A42B4BFE5464A7D1D0204B36C68@chzugexch01.abatos.com>
From: Graf Alex <alex.graf@siemens.com>
To: "'somshekar chandrashekar kadam'" <som_kadam1@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: AW: AW: compact flash
Date: Mon, 29 Sep 2003 18:26:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


do i need to first detect it on my PPCBOOT , or can I make it
DETECT directly from LINUX
>> it depends on what u want.
If u want only IDE support, no hotplug, u have to setup the PCMCIA registers
in ppcboot. The driver/pcmcia/ide-m8xx.c reads out the PCMCIA register and
remaps the io windows for IDE access. This is the simple way and it works
with www.denx.de ELDK.
for hotplug, the register setup (for linux) is in
driver/pcmcia/m8xx_pcmcia.c. U can set up the PCMCIA registers for ppcboot,
but it's not necesary. Then u need the pcmcia-cs package. This is the tricky
way and, depends on ur kernel, is not supported on all kernel versions!

cheers

Alex Graf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
