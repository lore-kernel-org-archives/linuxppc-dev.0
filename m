Message-ID: <19990925224650.18793.qmail@www0w.netaddress.usa.net>
Date: 25 Sep 99 17:46:50 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: Anirudh Joshi <ajoshi@Glue.umd.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Re: SndConfig for Linux/PPC]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anirudh Joshi <ajoshi@Glue.umd.edu> wrote:
> 
> 	heh... funny you bring this up, cause just yesterday i decided
> (was coaxed rather) to rewrite the awacs driver.  hopefully when i'm
> finished, it'll be out of dmasound.c and awacs.c will be done The Right
> Way (or whatever way i think is Right :).  anyhow, it'll have all the
> goodies like mixer support, etc...
> 
Still though, how would my program be able to detect the presence of mac style
sound device after your patch hits the tree? I say this because I would like
my program to first scan for PCI cards like the Ensoniq(assuming that if you
have one of these you don't want to use the built in sound), then look for
built-in (some IBM machines won't have this so I need to detect it and not
assume its there), or if neither is found prompt the user to explain why he is
running the program if he doesn't have a sound card.
> ani
> 
> On Fri, 24 Sep 1999, Jeramy B Smith wrote:
> 
> > 
> > I've been thinking about making sndconfig run on linuxppc. 
> > A. rip out the sun/sbus code
> > B. remove defs for isa cards
> > C. remove the defs for pci cards that don't work on linuxppc
> > D. add dma sound def
> > E. debug, debug, debug
> > F. Resync with RedHats source and beg them to add the PPC stuff

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
