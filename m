Date: Fri, 19 May 2000 18:24:13 -0400 (EDT)
From: Worth <haworth@ncal.verio.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: BMAC+ & Full Duplex
In-Reply-To: <20000519191318.30716@sjc2-relay.mail.digex.net>
Message-ID: <Pine.SOL.4.10.10005191803410.29326-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 May 2000, Benjamin Herrenschmidt wrote:

> [...]
> I've not find "standard" ioctl I could implement for that, so I beleive
> we just can invent a new one and add it to MACE, BMAC and GMAC drivers.
> I'll look into this when I'm back along with some GMAC fixes.

The last time I looked at that every driver that even supported
such options had its own unique compile time defines and/or
module parms. Standard ioctls that ifconfig could use would
be nice.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
