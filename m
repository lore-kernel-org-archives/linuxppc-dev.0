Date: Fri, 3 May 2002 09:59:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'acurtis@onz.com'" <acurtis@onz.com>
Subject: Re: linuxppc_2_4_devel - Walnut compile
Message-ID: <20020503165937.GE894@opus.bloom.county>
References: <FA06AA2C99BCD511951200005A994410438645@irvexch1.sextantifs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FA06AA2C99BCD511951200005A994410438645@irvexch1.sextantifs.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 03, 2002 at 09:39:36AM -0700, Curtis, Allen wrote:

> > > 2. linker error - early_serial* symbols undefined
> > >    modified drivers/char/Makefile - to include serial.c
> >
> > Turn on CONFIG_SERIAL.  No one has tested any of the 4xx configs w/o
> > CONFIG_SERIAL, so it's not supprising it didn't work.  I've
> > pushed a few
> > small things which might help however.
>
> I got this to build doing the following. In the process of testing it now.
>
> 1. Changed Standard/Generic Serial Port to [Y] from [M]
> 	This enabled the console on serial port option
>
> Notes:
> a) Makefile modifications were unnecessary in drivers/char.
> b) I guess that SICC is not appropriate.....

Right.  SICC is an STB03xxx-specific thing.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
