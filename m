Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: gdb problems
Date: Fri, 11 May 2001 17:38:52 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLKEEDENAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <IGEFJKJNHJDCBKALBJLLGEEBENAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi again

Next small problem:

How do i get gdb to debug assembler files?
if i do "list _start" in gdb i get a:
No line number information avaiable for address 0xfc0100 <_start>

I have tried a different gdb debuggers and options to gcc

    Jocke

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@lumentis.se]
> Sent: Friday, May 11, 2001 12:24
> To: Scott Anderson
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: RE: gdb problems
>
>
> Thanks, that did the trick.
>
> One small problem though. When I added -ggdb gcc complained about:
> "Error: relocation can not be done when using -mrelocatable"
>
> This is when I compile ppcboot. When I removed -mrelocateable, it
> compiled.
>
> Why is this?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
