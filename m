From: Graf Alex <alex.graf@siemens.com>
To: "'somshekar chandrashekar kadam'" <som_kadam1@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <791B3205DB661A42B4BFE5464A7D1D0204B36C6A@chzugexch01.abatos.com>
Subject: AW: AW: AW: compact flash
Date: Tue, 30 Sep 2003 09:26:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The IO address depends on your memory map!
Please have a look @ www.denx.de !
@ denx u can download a kernel. The MPC860 is supported there. Read the
manuals e.g the DULG document(they are very good!)

cheers

Alex

-----Ursprüngliche Nachricht-----
Von: somshekar chandrashekar kadam [mailto:som_kadam1@rediffmail.com]
Gesendet: Dienstag, 30. September 2003 08:01
An: Graf Alex
Cc: linuxppc-embedded@lists.linuxppc.org
Betreff: Re: AW: AW: compact flash



Hi Alex ,

    what do get this ATTRIBUTE address , IO address DMA ADDRESS
with respect to CF , where do i get this info
i know the MEM_ADDR in my memory map others i dont have any idea ,
where should i get it from

Thanks In Advance
SOm
On Mon, 29 Sep 2003 Graf Alex wrote :
>
>do i need to first detect it on my PPCBOOT , or can I make it
>DETECT directly from LINUX
> >> it depends on what u want.
>If u want only IDE support, no hotplug, u have to setup the
>PCMCIA registers
>in ppcboot. The driver/pcmcia/ide-m8xx.c reads out the PCMCIA
>register and
>remaps the io windows for IDE access. This is the simple way and
>it works
>with www.denx.de ELDK.
>for hotplug, the register setup (for linux) is in
>driver/pcmcia/m8xx_pcmcia.c. U can set up the PCMCIA registers
>for ppcboot,
>but it's not necesary. Then u need the pcmcia-cs package. This is
>the tricky
>way and, depends on ur kernel, is not supported on all kernel
>versions!
>
>cheers
>
>Alex Graf
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
