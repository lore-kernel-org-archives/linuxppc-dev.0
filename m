Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 28 May 2002 15:39:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Stephen Cameron <steve.cameron@hp.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bitkeeper trouble
Message-ID: <20020528223947.GD5997@opus.bloom.county>
References: <20020528222106.GC5997@opus.bloom.county> <20020528223319.BCE1011973@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020528223319.BCE1011973@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 12:33:14AM +0200, Wolfgang Denk wrote:
> In message <20020528222106.GC5997@opus.bloom.county> you wrote:
> >
> > What does 'bk parent' say?  If it's not
> > bk://ppc.bkbits.net/linuxppc_2_4_devel, try doing:
> > bk parent bk://ppc.bkbits.net/linuxppc_2_4_devel
> > and then pulling again.  I'm not sure why, but ppc.bkserver.net seems to
> > be gone.
>
> Well, from here it looks like a name server problem:
>
> Non-authoritative answer:
> Name:   ppc.bkserver.net
> Address: 10.3.9.222
>
> This explains why I get "no route to host" errors...

That would do it.  I think it's been broken for a while too (sometime
between the 24th and the 27th, since the mirror on source.mvista.com
stopped on the 24th).  Anyone want to ask Larry about it?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
