Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6CBA@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "''linuxppc-embedded@lists.linuxppc.org' '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: a general bootloader question
Date: Thu, 15 Nov 2001 12:12:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

The bootloader is also needed to initialize the HW.
You should have a look at PPCBoot. http://ppcboot.sourceforge.net/
It is free, made to be portable, used by a lot of people, has en interesting
readme and there is a mailing-list. When it starts the kernel it passes a
structure containing info on the detected HW.

I hope this helps
Fred


-----Original Message-----
From: Shie Erlich
To: 'linuxppc-embedded@lists.linuxppc.org'
Sent: 11/15/01 10:51 AM
Subject: a general bootloader question


hi,
i'm trying to get linux to run on my company's custom board (mainly
ppc750
and a cpc700 pci bridge).
we've been using visionICE to download the kernel to the target board,
and
have also tried using the
vxWorks bootloader (since it's already on the target's rom). The vxWorks
bootloader fails bigtime, since
it tries to load the kernel into --physical-- address 0xc0000000 and
crashes. The ICE however, fails since
it can't handle MMU and crashes as soon as it is turned on.

if anyone can help with the following question, i'd be really grateful:

1) what is the proper way to get the kernel to boot - do i need a
bootloader, if so, what ?

2) what is the bootloader's functionality - except downloading the
kernel ?
does it modify
    memory in any way ? is the kernel dependent on such modifications ?

3) how can i make a bootloader load the kernel in low memory without
changing KERNELBASE etc ?


		thanks in advance,
			Shie Erlich



    This e-mail message has been sent by Elbit Systems Ltd. and is for
the
use of the intended recipients only.  The message may contain
information
that is privileged or confidential.  If you are not the intended
recipient
you are hereby notified that any use, distribution or copying of this
communication is strictly prohibited, and you are requested to delete
the
e-mail and any attachments and notify the sender immediately.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
