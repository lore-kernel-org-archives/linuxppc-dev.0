Message-ID: <3AFADC76.B79662E0@mvista.com>
Date: Thu, 10 May 2001 18:22:46 +0000
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdb problems
References: <IGEFJKJNHJDCBKALBJLLGEDNENAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:
>
> Hi
>
> I am trying to debug ppclinux 2.4 and ppcboot on RPX CLLF board
> connected to an Abatron emulator.
>
> When I print variables in gdb I get an <error type> message
> instead of the variable value. Breakpoints and stack trace etc. works
> fine. I have enabled -g switch to gcc.

In order to get gdb to understand structs, etc. I compile with -ggdb
instead of -g.  Works quite well.  I'm spoiled now.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
