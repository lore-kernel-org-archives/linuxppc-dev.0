Message-ID: <gtsFDn5z0001IEGahU@andrew.cmu.edu>
Date: Sun,  8 Oct 2000 20:40:19 -0400 (EDT)
From: Joshua Anhalt <anhalt+@andrew.cmu.edu>
To: linux-ppc@meetpoint.aux.sps.mot.com
Subject: Re: Speech Recogniton
Cc: mnorton@cisco.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10009150815360.754-100000@sleepchamber.geekcentral.msoe.edu>
References: <Pine.LNX.4.10.10009150815360.754-100000@sleepchamber.geekcentral.msoe.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Check out the Speech Recognition Package on Source Forge. "Sphinx 2"  It
was originally developed at Carnegie Mellon University.  If you could
see the code of most commercial Speaker Independant Systems, you'd likly
see Sphinx running in there.  I believe Apple's system was developed
from sphinx.  could be way off here.

http://sourceforge.net/projects/cmusphinx/

I understand it compiles cleanly on Linux PPC.

joshua

Excerpts from internet.computing.linux-ppc: 15-Sep-100 Re: Speech
Recogniton by "Geiser, Ian"@msoe.edu
> > At 4:57 AM -0400 9/14/00, Michael Norton wrote:
> > >hi,
> > >
> > >Do any libraries exist that allow me to use the Apple Speech recognition
> > >hardware under LinuxPPC?
> >
> > Sorry, there is no hardware (aside from a simple digitizer to capture
> > the sound of course).  Apple's speech recognition is 100% software.
> >
> > The original implementation on 68K Macs used an AT&T DSP coprocessor
> > to do the crunching because the 68K didn't have enough oomph to do it
> > by itself, but the PowerPC implementation relies on nothing but the
> > CPU.
> >


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
