Message-ID: <39AF8F1B.D9F547EC@pop.agri.ch>
Date: Fri, 01 Sep 2000 13:12:47 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
References: <v04220803b5d51a99c774@[10.0.0.42]> <20000901110221.5823@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >1. Resource conflicts are reported for the CMD646 IDE controller and
> >an Adaptec 2940UW card
[snip]
> >4. Probably due to the resource conflict problem, the aic7xxx driver
> >doesn't recognize the 2940.  This is a showstopper for me because my
> >
> >root partition's on a drive connected to the 2940.
>
> I'll see what I can do.

For me the same happens, the root is sitting on the drive connected to
the 2940UW.
The patch from Geert which you posted to ppclinux.sourceforge.net would
solve this conflict. At least I could boot with it on my 7200.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
