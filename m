Date: Sun, 21 Dec 2003 12:23:29 +0100
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] tas3004_tables.c off-by-one
Message-Id: <20031221122329.4f21ee09.colin@colino.net>
In-Reply-To: <1071962774.8935.23.camel@gaston>
References: <20031220175850.416fb0ec.colin@colino.net>
	<1071962774.8935.23.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 21 Dec 2003 at 10h12, Benjamin Herrenschmidt wrote:

Hi,
> > I found out this was due to too short (by one item) arrays in
> > tas3004_tables.c. This patch fixes it. I just copied over the last entry
> > of each array.
>
> Interesting, my understanding is that those values were taken
> from Darwin ;)

That's what I thought too; that's a bit odd. debug printk()s clearly told me
that the kernel was trying to get array[101] of the 101 elements arrays :-)
Maybe Darwin doesn't allow the mixers to get to 100% ?

--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
