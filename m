Date: 30 Sep 2003 06:00:41 -0000
Message-ID: <20030930060041.18102.qmail@webmail27.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
Reply-To: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
To: "Graf Alex" <alex.graf@siemens.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: AW: AW: compact flash
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
