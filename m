Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Pantelis Antoniou" <panto@intracom.gr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: QMC driver for 860?
Date: Mon, 2 Dec 2002 16:09:32 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLEEHBFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3DEB676E.7090507@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> OK
>
> You asked for it ;).
>
> The file netvia_tsa.c is the actual QMC + stuff driver.
> The file netvia_bri.c is an example driver.
> The header files are the QMC definitions.
>
> Linux kernel version is 2.4.20.
>
> Don't hesitate to ask for any explanations.
>
> Pantelis

Thanks a lot!

I have just browsed the driver and I noticed that there is room for performance
improvements in netvia_tsa.c w.r.t memcpy(). You can avoid the memcpy() call
for received packets by using invalidate_dcache_range(). I did this for
the 8xx_io/enet.c driver a few weeks ago(it's not in BK yet).

See http://lists.linuxppc.org/linuxppc-embedded/200210/msg00317.html
and
http://lists.linuxppc.org/linuxppc-embedded/200210/msg00272.html

   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
