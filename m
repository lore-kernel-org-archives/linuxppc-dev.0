Date: Tue, 5 Dec 2000 13:59:19 +0200 (EET)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mount via nfs using MontaVista's Linux for IBM405
In-Reply-To: <3A2CC1A9.8A0E8DC2@esd-electronics.com>
Message-ID: <Pine.GSO.4.30.0012051357150.16118-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 5 Dec 2000, Matthias Fuchs wrote:

>When I do a: mount -t nfs <nfs-servers-ip>:/home/matthias /test on the
>405 board, I get this output (after some delay):
>
>	nfs warning: mount version older than kernel
>	portmap: server localhost not responding, timed out
>	portmap: server localhost not responding, timed out
>	lockd_up: makesock failed, error=-5
>
>But I can still telnet to the board (it does not crash) but I cannot
>interrupt the mount call.
>
>The nfs server is working properly, because I get the root filesystem
>from the same server (with no problems).

I am using 2.4.0-test2 aswell, but on a motorola sandpoint platform...
I get exactly the same messages as you do, but without the last one
("lockd_up: makesock failed...") and the mount works after a delay
(5 minutes or so)... I don't exactly know what is the reason for that,
but have you tried to set up a loopback interface for the localhost
aswell? It just might solve the problem, obviously portmap is trying
to contact the portmapper on localhost aswell...


-topi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
