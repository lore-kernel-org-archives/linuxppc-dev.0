Date: Fri, 17 Mar 2000 09:13:35 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: jingai <jingai@floatingpenguins.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: shmget failing w/ kernel 2.3.52
In-Reply-To: <200003170759.CAA08719@shell.faradic.net>
Message-ID: <Pine.LNX.4.05.10003170912280.17521-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 16 Mar 2000, jingai wrote:
> Quickie question:  after upgrading to kernel 2.3.52 (paul's tree), suddenly
> all calls to shmget are failing.. anyone have any idea why?

Add

    # shm file system:
    none            /var/shm        shm     defaults                0       0

to your /etc/fstab and mount /var/shm.

Gr{oetje,eeting}s,


						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
