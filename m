From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>, <toe@unlserve.unl.edu>
Subject: Re: Discrepancy in BAT mapping?
Date: Tue, 12 Sep 2000 11:01:20 +0200
Message-Id: <20000912090120.4362@192.168.1.10>
In-Reply-To: <200009112000.WAA00793@piglet.grunz.lu>
References: <200009112000.WAA00793@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hmmm, setting the G bit for instruction pages should never be necessary.
>I may be totally wrong, but as I see the logic, your instructions are
>not supposed to modify themselves when read. So there is no reason to
>protect them from speculative access. Hence, clear the G bit on all
>instruction-only mappings, so speculative access may be used to a
>performance advantage.

Well, who will ever execute code out of the framebuffer anyway ? Also, I
beleive we can remove the G bit completely, there's no need to prevent
speculative access to the fb. I'll look into this.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
