Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <937610FE9B70D511B3E700508B8B65770E53B1@MAIL1>
From: Shie Erlich <shie_e@elbit.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: a general bootloader question
Date: Thu, 15 Nov 2001 11:51:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
i'm trying to get linux to run on my company's custom board (mainly ppc750
and a cpc700 pci bridge).
we've been using visionICE to download the kernel to the target board, and
have also tried using the
vxWorks bootloader (since it's already on the target's rom). The vxWorks
bootloader fails bigtime, since
it tries to load the kernel into --physical-- address 0xc0000000 and
crashes. The ICE however, fails since
it can't handle MMU and crashes as soon as it is turned on.

if anyone can help with the following question, i'd be really grateful:

1) what is the proper way to get the kernel to boot - do i need a
bootloader, if so, what ?

2) what is the bootloader's functionality - except downloading the kernel ?
does it modify
    memory in any way ? is the kernel dependent on such modifications ?

3) how can i make a bootloader load the kernel in low memory without
changing KERNELBASE etc ?


		thanks in advance,
			Shie Erlich



    This e-mail message has been sent by Elbit Systems Ltd. and is for the
use of the intended recipients only.  The message may contain information
that is privileged or confidential.  If you are not the intended recipient
you are hereby notified that any use, distribution or copying of this
communication is strictly prohibited, and you are requested to delete the
e-mail and any attachments and notify the sender immediately.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
