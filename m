From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15459.65390.787694.577725@gargle.gargle.HOWL>
Date: Fri, 8 Feb 2002 10:40:14 -0600
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC107 I2C
In-Reply-To: <20020208162309.395f7c2f.adrian@humboldt.co.uk>
References: <20020208094057.799c099a.adrian@humboldt.co.uk>
	<3C63F5A4.5070608@embeddededge.com>
	<20020208162309.395f7c2f.adrian@humboldt.co.uk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian Cox writes:
>
> On Fri, 08 Feb 2002 10:58:28 -0500
> Dan Malek <dan@embeddededge.com> wrote:
>
> > Adrian Cox wrote:
> >
> > > Does anybody know of an I2C driver for the MPC107?  The only clue I
> > > found on Google (searching for "MPC107 linux i2c") was a post by Dan
> > > Malek saying "I believe the code is lurking around somewhere".
> >
> > I wrote that :-)?  Must have been one of my more foggy days.  Any time
> > a question like that is asked I scan the archives looking for tidbits of
> > information.  I must have found someone that posted something about it.
>
> Apparently so:
>
> http://www.geocrawler.com/archives/3/8358/2001/9/0/6707253/
>
> > I believe there is (was, it's harder to find these days without registration)
> > software on Motorla's website to do this.  I tend to avoid sites that
> > require a) registration and, b) Internet Exploder to work properly, so I
> > don't know what is on their website these days.
>
> I'll take a look. I find Motorola's website a complete pain to navigate,
> so I try to avoid it as well. Searching for "+linux +i2c +mpc107" on
> Motorola's site finds 5 documents, none of them relevant.

No linux drivers, but the moto code (for the 8240) is in the ppcboot
tree these days, and I know that gbios has enough of i2c up to read
SODIMMs.

Did my question about EUMBBAR and the 8245's serial port(s) not make
it out to the list?

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
