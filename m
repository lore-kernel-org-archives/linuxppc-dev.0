From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Blanton <eblanton@cs.ohiou.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Internal airport card not working? (2.4.6-benh)
Date: Sun, 15 Jul 2001 23:08:32 +0200
Message-Id: <20010715210832.9850@smtp.wanadoo.fr>
In-Reply-To: <20010715170446.A20595@localhost.localdomain>
References: <20010715170446.A20595@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Not that I see...  I see nothing in my log until the removal and
>reinsertion of the drivers, at which point I just see a 'su' and then
>the driver banner messages.
>
>Everything *acts* like it's working, it just doesn't.  If that makes
>sense.  :-)
>Ethan

Not much for now, I suspect a problem with the card's power up sequence
which may not wait long enough for the card to be up...

Do you see anything wrong with packets emitted by the card ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
