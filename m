Message-ID: <20030219181822.14372.qmail@web41205.mail.yahoo.com>
Date: Wed, 19 Feb 2003 10:18:22 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: rs_timer
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030218220140.GA5039@mail.cryptoapps.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Folks,

I observed that, even after linux boots and INIT
process starts, rs_timer stays active and causes the
rs_interrupt_single to be called.

I saw a posting on rs_timer on this message board by
mvista, which says
----------
> Once you hit userland, /dev/ttyS0 is opened and
serial I/O is normally interrupt driven. Prior to that
it uses the polled serial console routines in the
driver. Now, the rs_timer() kludge claims to work for
non-interrupt driven I/O but I've never heard of
anybody using it. You should just hook up your
interrupt controller.
----------

If this is true, after INIT process is invoked, why
does the rs_timer function is called? ByTheWay, my
interrupt controller is on.

Thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
