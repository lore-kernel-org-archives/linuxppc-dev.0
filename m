From: Benjamin Herrenschmidt <bh40@calva.net>
To: Tom Rini <trini@kernel.crashing.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: whacked out 2.2.18preX - last gasp
Date: Tue, 21 Nov 2000 17:17:50 +0100
Message-Id: <19341016094934.2031@192.168.1.2>
In-Reply-To: <20001121083623.H552@opus.bloom.county>
References: <20001121083623.H552@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Actually, the linuxppc_2_5 bitkeeper tree (which is getting merged into
>2_3, for inclusing into hopefully 2.4.0-final from linus) has a giant PCI
>re-write, so 9500s/et al might actually work happily now.  But yes, from what
>I've gathered from trying to work w/ a 9500 and 2.2.18pre21 there just might
>be something broken now.  (The video card refuses to work at all, regardless
>of slot).

_2_5 will help configs with multiple PCI busses except for IO ports which
will still be available on the first bus only. This may get fixed for PCI
IO BARs if we end up mapping virtually all the IO spaces appended together.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
