Date: Mon, 22 Oct 2001 13:59:16 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: idebus=133 ?
In-Reply-To: <20011022194702.1461@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0110221357400.11960-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Oct 2001, Benjamin Herrenschmidt wrote:

> Well. I don't even know if it's really a 66Mhz slot, or some kind of
> hacked 33Mhz with a doubled clock (I don't know if it really follow
> the PCI spec for 66Mhz). I heard noise when the machine was released
> about that slot not beeing completely standard.

The PCI bus spec allows for up to 66 MHz bus clock with a 64-bit-wide bus.
Some systems (most notably Alpha-based systems) actually implemented such
slots.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
