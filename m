Date: Mon, 22 Jan 2001 21:43:07 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: michdaen@iiic.ethz.ch, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6C8C6E.3C19F151@mvista.com>
Message-ID: <Pine.GSO.4.10.10101222110460.23057-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Dan Malek wrote:

> ...I don't know who wrote:

(That was I too :). )

> > > > There is no pte table and so there is nothing mapped at that address,
>
> No, there is a pte table there, you just didn't get to printing
> anything from it......

Nope, there is no pte table, otherwise pte had been a valid pointer into
that table, so it's just the offset for that table.

> Err...ahhhh...I don't know if I would go looking in that file for
> examples.  I would prefer to understand the problem we are trying to
> solve, and perhaps write some functions to call if necessary.  Scattering
> code from functions in this file into other places may not be a good
> thing.

Sure, one missing information is, how he got that address.
Anyway, looking up virtual kernel memory that way is possible, with
ioremapped memory it already is dangerous, but for that you also don't get
any page struct.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
