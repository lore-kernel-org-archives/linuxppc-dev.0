Date: Fri, 10 Sep 1999 19:55:15 -0400 (EDT)
From: "Joshua M. Thompson" <funaho@jurai.org>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.18 and CONFIG_ADB_MOUSE
In-Reply-To: <37D98144.97257D77@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9909101954130.10100-100000@ifurita.jurai.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 11 Sep 1999, Martin Costabel wrote:

> And in arch/ppc/config.in, the line
> 
>    bool 'Support for PowerMac ADB mouse' CONFIG_ADBMOUSE
> 
> got trashed, probably by mistake.

Nope, it's superceded by CONFIG_ADB_MOUSE. The ADB mouse driver is
cross-platform now.

-- 
funaho@jurai.org             | Voodoo is a very interesting religion for the
http://www.jurai.org/~funaho | whole family, even those members of it who are
                             | dead.
                             |  -- (Terry Pratchett & Neil Gaiman, Good Omens)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
