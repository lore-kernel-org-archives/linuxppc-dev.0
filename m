Date: Tue, 3 Oct 2000 19:23:04 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Olaf Hering <olh@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 +
 atidriverwith rage II/rage pro)
In-Reply-To: <39DA138F.EFC230F@relog.ch>
Message-ID: <Pine.LNX.4.10.10010031920530.15957-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Looks like that special chip needs a little extra setup in the kernel
> > > code?
> >
> > Nope, X doesn't handle 32 bit depth (I've looked at the ati driver for
> > hours to no avail). The kernel driver has all necessary code to set up
> > the engine for 32 bit depth (rgb weight 8888).
>
> I'll say it again: 32 bpp is depth 24, 32 fbbpp in X 4 terms. No depth 32 yet.

That's what I meant to say. Sorry if it was prone to misunderstanding, my
intention wasn't to bash X.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
