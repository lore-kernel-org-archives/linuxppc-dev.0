Date: Sun, 10 Sep 2000 12:59:15 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Discrepancy in BAT mapping?
In-Reply-To: <20000901105738.4534@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000910124843.660G-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

In arch/ppc/kernel/prom.c, frame buffer is mapped via BAT with
_PAGE_GUARDED for 603, 604, 750, etc.  The same value is loaded to both
IBAT and DBAT in arch/ppc/kernel/head.S.

However, in arch/ppc/mm/init.c's setbat(), G bit is stripped off for IBAT.

I suppose it doesn't matter too much since it's frame buffer, but which is
correct technically?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
