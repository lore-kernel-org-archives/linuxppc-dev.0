In-Reply-To: <Pine.LNX.4.05.10002111739060.387-100000@callisto.of.borg>
Date: Fri, 11 Feb 2000 18:05:24 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-bk@fsmlabs.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Latest OpenPic changes
Message-Id: <20000211180524.028896@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 11, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>and OPENPIC_MASK is still set when the loop times out on enabling
>IRQ_8259_CASCADE in chrp_init_IRQ(). How is this possible? There's an eieio()
>after each register write and the mb() does sync.

Is this the only interrupt causing this behaviour ? I beleive that means
either the mask register is not implemented for the cascade or a hw bug.
I'll try to have a look at my docs this week-end.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
