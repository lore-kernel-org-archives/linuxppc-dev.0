Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Scott Anderson" <scott_anderson@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: gdb problems
Date: Fri, 11 May 2001 12:23:32 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLGEEBENAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3AFADC76.B79662E0@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, that did the trick.

One small problem though. When I added -ggdb gcc complained about:
"Error: relocation can not be done when using -mrelocatable"

This is when I compile ppcboot. When I removed -mrelocateable, it compiled.

Why is this?

 Jocke

> In order to get gdb to understand structs, etc. I compile with -ggdb
> instead of -g.  Works quite well.  I'm spoiled now.
>
>     Scott Anderson
>     scott_anderson@mvista.com   MontaVista Software Inc.
>     (408)328-9214               1237 East Arques Ave.
>     http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
