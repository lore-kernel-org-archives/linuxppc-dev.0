Message-ID: <39D4E85F.926CFD5B@mvista.com>
Date: Fri, 29 Sep 2000 12:07:11 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Dan Malek <dan@mvista.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <19340822040932.8760@mailhost.mipsys.com>
		<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
		<14803.57550.118150.759977@argo.linuxcare.com.au>
		<39D41AA2.C586D738@mvista.com> <14804.7238.688771.238444@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Dan Malek writes:
>
> > Paul Mackerras wrote:
> >
> > > My proposal would simplify inb/outb by making _IO_BASE a constant
> > > rather than a variable.
> >
> > That's the way it used to be, then all of the different ports made
> > a mess of io.h because everyone wanted it different.  Then it became
> > a variable (sort of) and the mess moved to platform dependent files,
> > now it is coming back.....Why will it be different this time :-)?
>
> Because we'll make it the same value for all ports.  Anybody got any
> objections to 0xff000000?
>
> Paul.
>
> --
> Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
> +61 2 6262 8990 tel, +61 2 6262 8991 fax
> paulus@linuxcare.com.au, http://www.linuxcare.com.au/
> Linuxcare.  Support for the revolution.
>

Yes.  It is equivalently mapped on the PPC 405 at 0xe8000000.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
