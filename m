Date: Thu, 29 Nov 2001 09:36:02 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_ALL_PPC
In-Reply-To: <20011128164306.D29541@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0111290927170.15554-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Nov 2001, Tom Rini wrote:

>
> On Thu, Nov 29, 2001 at 09:07:12AM +1100, Paul Mackerras wrote:
> >
> > I want to rename CONFIG_ALL_PPC to CONFIG_PREP_PMAC_CHRP in the
> > linuxppc_2_4_devel tree (or if anyone can suggest a better name I'll
> > use that).
> >
> > Does anyone object to this?
>
> Yes.  For historical note, the old 2_5 tree had CONFIG_WORKSTATION_PPC,
> which suited most people.  But there's the fact that most of the
> 7xx/74xx boards in _devel now can take a video card and be a
> 'workstation' too. :)

Right. But even older ones, for example I have MVME boards with PMC video
modules (that's _the_ reason for which I wrote a x86 BIOS ROM emulator,
which will hopefully end up one day in the source tree) which are almost
5 years old.

MVME boards for example are not workstation and yet are PreP or OF-less
CHRP. Why not doing it the other way around, or at least not presenting
the option in the configuration: if you don't select a specific machine,
set CONFIG_{ALL,COMMON,VULGAR,GENERIC}_PPC (pick te one you prefer, I'm
not a native english speaker).

Of course you could also invert the "polarity" of the definition, although
having to select the CONFIG_ELITIST_PPC to specify a non Pmac/PreP/CHRP
machine might not sound politically correct to some people :-)
CONFIG_SPECIFIC_PPC does not sound that bad, however.

[The following is a message from Tom on July 5th, I had started to answer
and then it got lost in a long list of postponed-msgs: it's the day my
second son was born :-)]

> > Which leads me to ask what are the advantages of making gemini part of
> > CONFIG_ALL_PPC?  Is it that gemini is sufficiently close to a prep
> > that we might as well treat it as a prep?
>
> I'm definatly not an expert on the boards, but, iirc, they're as 'PReP' as
> many of the ports in 2_4_devel.  They're not 100% compliant, but they
> could work, but sub-optimally.

It's hard to tell which boards are 100% PreP compliant, given the
fuzzyness of the specification.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
