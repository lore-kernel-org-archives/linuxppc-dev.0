Return-Path: <medp@primagraphics.com>
Received: from mail.primagraphics.com (unknown [81.20.3.25])
	by ozlabs.org (Postfix) with SMTP id 52A402BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Oct 2004 19:17:27 +1000 (EST)
Message-ID: <41777D14.7090108@primagraphics.com>
Date: Thu, 21 Oct 2004 10:10:44 +0100
From: Mark Powell <medp@primagraphics.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: gdb on a 440GP ELDK
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I hope this is not a dumb question.
I can't seem to use breakpoints in gdb (application debugging in 
userland not kernel debugging).
The system is a custom 440GP card, running the kernel from ELDK 3.0, 
modified for this card. The card is based heavily on the Ebony. I am 
using the ELDK f/s as NFS root.
The system seems to basically run fine apart from the fact that gdb 
doesn't stop at any breakpoints.
Is there any known issue with this combination of gcc/binutils/gdb ?
Versions are:

    GNU gdb Yellow Dog Linux (5.2.1-4b_3)
    gcc (GCC) 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_2)
    GNU assembler 2.13.90.0.18 20030206

TIA
