Date: Fri, 10 Jan 2003 16:19:00 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Definitions for c_cflag etc. in termbits.h???
In-Reply-To: <3E1EE23F.5BC310F3@imc-berlin.de>
Message-ID: <Pine.LNX.4.52.0301101617120.10676@mag.devdep.sysgo.de>
References: <3E1EE23F.5BC310F3@imc-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 10 Jan 2003, Steven Scholz wrote:

> ./include/asm-ppc/termbits.h:
>
> E.g. the DEFINEs of c_iflags appear to me as decimal values!?
>
> /* c_iflag bits */
> #define IGNBRK  0000001

It's octal (note the leading zero).

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
