Date: Thu, 1 Nov 2001 10:07:48 -0500 (EST)
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bill Fink <billfink@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: sungem driver won't compile on latest benh kernel
In-Reply-To: <20011101105224.4312@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0111011005050.11949-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 1 Nov 2001, Benjamin Herrenschmidt wrote:

> >When trying to do a make modules on the latest benh kernel (2.4.14-pre5-
> ben0),
> >the compile of the sungem driver fails spectacularly.  It looks like there
> >are missing include files linux/mii.h and linux/ethtool.h, plus undefined
> >variables and labels.  It was more than I wanted to mess with.  I was
> >interested in comparing the GigE performance of the gmac and sungem drivers,
> >but I guess I'll wait.
>
> I'm working on it and didn't finish yet.

Hi Ben,

Thanks for the info.  I suspected as much, so I'll wait a while and
give it a try again later.  I'm looking forward to giving it a spin
once it's ready.

						-Thanks

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
