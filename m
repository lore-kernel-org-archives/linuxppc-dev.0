Date: Thu, 15 Jan 2004 08:44:39 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF properties access ?
Message-ID: <20040115074439.GB14039@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074131387.818.43.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 15, 2004 at 12:49:47PM +1100, Benjamin Herrenschmidt wrote:
>
> > But, the pmac OF (at least on the powerbook i got someone to check for
> > me), does have a l2cr property, not a l2cr-value one. The same goes on
> > for voltaire.debian.org, which is a dual G4 500MHz.
> >
> > Does this mean that the -value appended is for looking at the content of
> > l2cr, or something such ?
>
> No. The L2 is assumed to be set by the firmware. That "l2cr-value" is just
> an optional thing that BootX can set before booting the kernel to force
> a different L2 setup, typically used with G3 upgrade cards.

Ok.

But this doesn't reply me on why my attempts to read back integer values
from OF property only result in the machine hanging, and since it is
really early on, i don't even get serial console output to have an idea
why :/

in particular i cloned the code reading l2cr-value, and changed it to
l2cr and instead of reading the value, i got only kernel silently dying.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
