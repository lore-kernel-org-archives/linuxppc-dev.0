Date: 30 Sep 2003 04:08:37 -0000
Message-ID: <20030930040837.11936.qmail@webmail17.rediffmail.com>
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


Hi Alex,

   so u mean to say i need not enable it in PPCBOOT , yes i want t
use CF as IDE , correct me i fI am wrong
Thanks A Lot
SOmshekar

On Mon, 29 Sep 2003 Graf Alex wrote :
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


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
