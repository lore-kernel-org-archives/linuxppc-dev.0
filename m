Message-ID: <402A4ABF.8040801@imc-berlin.de>
Date: Wed, 11 Feb 2004 16:31:11 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: DavidHo@nanometrics.ca
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EXT_DIRECT IDE Mode
References: <OF3324B9C2.51BE135A-ON85256E37.00512C20-85256E37.00527916@nanometrics.ca>
In-Reply-To: <OF3324B9C2.51BE135A-ON85256E37.00512C20-85256E37.00527916@nanometrics.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


DavidHo@nanometrics.ca wrote:

> My application needs a compactflash and a 1.8" disk drive connected to the
> MPC852T.  Since the compact flash has already taken up the only PCMCIA
> slot, the disk drive is directly attached to the PPC bus so I need to
> enable EXT_DIRECT for the disk drive.
Ok.

> I haven't been able to make linux call the ide_init_hwif function.  I
> looked at how ide.c works and it looks like it enables IDE interfaces on
> the PCI first (ide_default_io_base returns non-zero).  I haven't yet been
> able to find out where it call my function.
>
> Would you be able to tell me how you got this mode working.

I do if you tell me which kernel version you tried.
I guess you have

CONFIG_BLK_DEV_MPC8xx_IDE=y
# CONFIG_IDE_8xx_PCCARD is not set
# CONFIG_IDE_8xx_DIRECT is not set
CONFIG_IDE_EXT_DIRECT=y

in your .config file?

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
