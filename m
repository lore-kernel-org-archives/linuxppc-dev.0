Date: Sun, 26 Sep 1999 14:35:34 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@sonycom.com>
cc: Anirudh Joshi <ajoshi@Glue.umd.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: SndConfig for Linux/PPC
In-Reply-To: <Pine.GSO.4.10.9909262208590.11268-100000@begonia.sonytel.be>
Message-ID: <Pine.LNX.4.10.9909261433140.8691-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 26 Sep 1999, Geert Uytterhoeven wrote:

> 
> On Fri, 24 Sep 1999, Anirudh Joshi wrote:
> > 	heh... funny you bring this up, cause just yesterday i decided
> > (was coaxed rather) to rewrite the awacs driver.  hopefully when i'm
> > finished, it'll be out of dmasound.c and awacs.c will be done The Right
> > Way (or whatever way i think is Right :).  anyhow, it'll have all the
> > goodies like mixer support, etc...
> 
> Why remove the AWACS code from damsound.c? In't it better to enhance
> dmasound.c, so Amiga/Atari users benefit from your enhancements as well?

Not really.  AWACS is like 3 different chips as it is.  In reality,
dmasound.c should go away.  The common code between the atari, amiga, and
various other chips which dmasound kinda "works" on can be in one file,
then amigasound, atarisound, then awacs (which would still be dealing w/ 3
different chips) for pmacs.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
