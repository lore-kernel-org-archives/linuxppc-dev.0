Subject: Re: U-Boot and kernel 2.6
From: Kenneth Johansson <ken@switchboard.ericsson.se>
To: Mark Chambers <markc@mail.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <002a01c44fc9$201dc820$0301a8c0@chuck2>
References: <20040611140919.84651C109F@atlas.denx.de>
	 <40C9BED6.3010809@intracom.gr>
	 <1086964452.15845.1308.camel@hades.cambridge.redhat.com>
	 <002a01c44fc9$201dc820$0301a8c0@chuck2>
Content-Type: text/plain
Message-Id: <1086972539.4640.65.camel@spawn.uab.ericsson.se>
Mime-Version: 1.0
Date: Fri, 11 Jun 2004 18:48:59 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-06-11 at 17:31, Mark Chambers wrote:
> > > Yeah, having the bi_recs interface actually working
> > > would be ideal, but at the present time nothing is
> > > working and as AFAIK no-one is working on it.
> >
> > So we should offer some gentle encouragement. Like refusing to accept
> > any further modifications to include/asm-ppc/ppcboot.h.
> >
>
> Here's another idea - how about XML?  That would be two steps forward, IMO,
> instead of just going from one magic structure to another.

Well XML of all things must be magic considering that it automatically
solves all problems all the time.

> As to just trashing bd_t, does that mean users have to upgrade their
> bootloader to use newer kernels, and could not switch back easily if
> problems arose?  Perhaps the kernel could identify whether the pointer is to
> a bd_t or something else and handle it automatically?

Don't worry this will never change the problem is not creating a big
enough itch so nobody will do anything (again).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
