Message-ID: <3A2D4B81.F0238326@mvista.com>
Date: Tue, 05 Dec 2000 12:09:37 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
CC: linuxppc-embedded@lists.linuxppc.org, frowand@mvista.com
Subject: Re: mount via nfs using MontaVista's Linux for IBM405
References: <3A2CC1A9.8A0E8DC2@esd-electronics.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthias Fuchs wrote:
>
> Hello,
>
> I am trying to mount a directory from a nfs server to my IBM405GP board.
>
> Here are the facts:
>
>         Kernel on our 405 board: 2.4.0-test2_mvista_001126
>         Root filesystem: target_ftest4 from MontaVista
>
> When I do a: mount -t nfs <nfs-servers-ip>:/home/matthias /test on the
> 405 board, I get this output (after some delay):
>
>         nfs warning: mount version older than kernel
>         portmap: server localhost not responding, timed out
>         portmap: server localhost not responding, timed out
>         lockd_up: makesock failed, error=-5
>
> But I can still telnet to the board (it does not crash) but I cannot
> interrupt the mount call.
>
> The nfs server is working properly, because I get the root filesystem
> from the same server (with no problems).
>
> Has anybody a solution for this problem ?
>
> Matthias
> --
> -------------------------------------------------
> \ Matthias Fuchs                                 \
>  \ esd electronic system design Gmbh              \
>   \ Vahrenwalder Straße 205                        \
>    \ D-30165 Hannover                               \
>     \ email: matthias.fuchs@esd-electronics.com      \
>      \ phone: +49-511-37298-0                         \
>       \ fax:   +49-511-37298-68                        \
>        --------------------------------------------------
>

Add the "-o nolock" option to the mount command.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
