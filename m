From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
Date: Thu, 28 Sep 2000 22:57:55 +0000
Message-Id: <19340823162939.7728@192.168.1.10>
In-Reply-To: <200009282107.XAA00763@piglet.grunz.lu>
References: <200009282107.XAA00763@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>And that machine check exception is not recovered from (would that even
>be possible?), hence a plain old kernel panic.

I have code that make it oops instead. It's in the linuxppc_2_5 bk tree,
but I beleive it need some refinements. (Currently, it tries too hard to
oops instead of panic'ing).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
