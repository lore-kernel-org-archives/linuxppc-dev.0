From: benh@kernel.crashing.org
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: crash on sleep with 2.4.19-pre4-ben0
Date: Thu, 28 Mar 2002 13:24:37 +0100
Message-Id: <20020328122437.7210@mailhost.mipsys.com>
In-Reply-To: <E16qVWR-0000Ez-00@piglet.grunz.lu>
References: <E16qVWR-0000Ez-00@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Per System.map, I was able to verify that at least one previous crash
>(with 2.4.18-rc4-benh) was in the same place.
>
>When these crashes started, I had changed, modulo kernel version of
>course, these things:
>
>- started to use unmasq_irq on the hd,
>- installed pbbuttonsd & gtkpbbuttons
>
>Removing both doesn't help. Also, it seems I need to power-off after a
>crash to get airport back to life.
>
>Anybody with more insight?

Can you get a backtrace ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
