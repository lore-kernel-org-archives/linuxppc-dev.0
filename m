Date: Mon, 13 Sep 1999 01:43:04 -0400 (EDT)
From: "Joshua M. Thompson" <funaho@jurai.org>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.18 and CONFIG_ADB_MOUSE
In-Reply-To: <37DA0CF4.74840414@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9909130140010.29981-100000@ifurita.jurai.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 11 Sep 1999, Martin Costabel wrote:

> I had seen the typo in drivers/char/Config.in, but forgot to correct it.
> And then it seemed more logical to have the selection of ADB_MOUSE next
> to ADB_KEYBOARD, but maybe it isn't. 

It is more logical, and that's the way I have it listed on the 68K Mac
port. What I believe should happen is that the ADB keyboard driver should
be put in drivers/char where the mouse driver already resides. Then they
can both be listed next to each other in the drivers/char/config.in file,
bracked by a nice clean 'if [ "$CONFIG_ADB" = 'y' ];'

-- 
funaho@jurai.org             | Voodoo is a very interesting religion for the
http://www.jurai.org/~funaho | whole family, even those members of it who are
                             | dead.
                             |  -- (Terry Pratchett & Neil Gaiman, Good Omens)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
