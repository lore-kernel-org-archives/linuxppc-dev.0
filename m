Date: Thu, 19 Oct 2000 16:22:32 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Nelson Abramson <pogtal@erols.com>, Jean-Jacques.Levy@inria.fr,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: video mirroring mode + acrobat reader
In-Reply-To: <Pine.LNX.4.10.10010191516570.422-100000@cassiopeia.home>
Message-ID: <Pine.HPX.4.10.10010191619560.3208-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Oct 2000, Geert Uytterhoeven wrote:

> On Wed, 18 Oct 2000, Gabriel Paubert wrote:
> > On Wed, 18 Oct 2000, Nelson Abramson wrote:
> > > Jean-Jacques Levy wrote:
> > > > <snip>
> > > > Can we have Acrobat reader working on LinuxPPC? Not xpdf which I feel
> > > > very poor?
> > >
> > > Acroread is ia-32 only.  It is binary, closed source software.  Unless you
> > > can convince Adobe to release a PPC version or port it yourself via an
> > > NDA, the answer is to use xpdf.
> >
> > Don't they have an AIX version around ? I have the HP-UX one for sure.
>
> How well does the AIX version run under Linux/PPC? :-)

Well, I don't know. I don't have access to any AIX box, but some
linker scripts were changed (start address raised to 256Mo=0x10000000) for
reasons of similarity with AIX or so. Ask Cort, he did the changes, so he
must have had a good reason to do it.

Maybe Linux/PPC binaries can be made to run under AIX ?

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
