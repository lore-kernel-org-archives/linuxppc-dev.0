Message-ID: <FA06AA2C99BCD511951200005A994410438645@irvexch1.sextantifs.com>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	"Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'acurtis@onz.com'" <acurtis@onz.com>
Date: Fri, 3 May 2002 09:39:36 -0700
Subject: RE: linuxppc_2_4_devel - Walnut compile
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I hopefully just fixed xconfig.  Now I need to talk to Keith Owens to
> get the proper fix pushed onto Marcelo.
>

Thanks

> > 2. linker error - early_serial* symbols undefined
> >    modified drivers/char/Makefile - to include serial.c
>
> Turn on CONFIG_SERIAL.  No one has tested any of the 4xx configs w/o
> CONFIG_SERIAL, so it's not supprising it didn't work.  I've
> pushed a few
> small things which might help however.

I got this to build doing the following. In the process of testing it now.

1. Changed Standard/Generic Serial Port to [Y] from [M]
	This enabled the console on serial port option

Notes:
a) Makefile modifications were unnecessary in drivers/char.
b) I guess that SICC is not appropriate.....

> > 4. Reviewed arch/ppc/config.in and discovered the following
>
> Fix this as well (missing space was the actual problem).

Yup, that is what I did....

Thanks for the help!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
