Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Pantelis Antoniou" <panto@intracom.gr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Regarding consistent_alloc
Date: Fri, 6 Dec 2002 15:25:48 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLCEJFFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3DF0A4D9.4030603@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

If you implement the performance improvement I suggested earlier, I don't think
you need them. Another thing with consistent_xxx() is that you can not use
__pa() and __va() on addresses returned by the consistent_alloc et. al.

I think Dan Malek and/or Tom Rini knows more about these functions.

   Jocke

>
> Pantelis Antoniou wrote:
>
> >
> > Hi
> >
> > Can someone tell what is the deal with these functions?
>
>                    ^ me
>
> >
> >
> > consistent_alloc et. al. are very useful to me now that I'm
> > cleaning up my QMC driver. But they are exported.
>
>                                          ^ not
>
> >
> >
> > Is there any reason why they are not exported for use by
> > modules?
> >
> > Also they appear to be tied to the PCI bus, a reduntant
> > dependancy IMHO.
> >
> > Regards
> >
> > --
> > Pantelis Antoniou
> > INTRACOM S.A. Greece
> >
> > "> I read slashdot because it's so hard to find
> > >> anything else intelligent to read.
> >
> > Keep searching..."
> > -- as seen on slashdot --
> >
> >
> >
> >
>
> Sigh,
>
> Maybe I should read the mail more before hitting send.
>
>
>
>
> --
> Pantelis Antoniou
> INTRACOM S.A. Greece
>
> "> I read slashdot because it's so hard to find
> >> anything else intelligent to read.
>
> Keep searching..."
> -- as seen on slashdot --
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
