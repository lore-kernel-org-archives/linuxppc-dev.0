Date: Thu, 05 Apr 2001 10:05:19 +0100
Subject: Re: Old (1.0.5) OF parsing broken in 2.4.3?
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010405090510.5334DDB9C8@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote:
> my 9600/233 has (OF 1.0.5) :
>
> /bandit/gc/davbus
> with: "AAPL,address" and "AAPL,interrupts" properties.
>
> this shows up in my new sound driver as:
> (node->n_addrs = 0, node->nr_ints = 3)
>
> /bandit/gc/davbus/sound
> with: "reg" property.
>
> this shows up as:
> (node->n_addrs = 0, node->nr_ints = 0)
>
> so neither OF node works to launch dmasound :-((
>
> Have I made a mistake in the new version - or has the OF parsing changed?
> (my code works fine on g3/beige & lombard)...

I should add it also has an "/bandit/gc/awacs" node which (I used to use)
and has:

"AAPL,address", "AAPL,interrupts" & "reg" propeties (and *does* work).

So perhaps I've got the wrong idea?
It would be much tidier to use the davbus node...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
