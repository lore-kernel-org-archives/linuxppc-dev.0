Message-ID: <3D10A455.7682EF16@imc-berlin.de>
Date: Wed, 19 Jun 2002 17:33:41 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <3D106922.7026437A@imc-berlin.de> <20020619150520.GA12762@opus.bloom.county> <3D10A0AC.409EF92B@imc-berlin.de> <20020619152528.GB12762@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:
>
> On Wed, Jun 19, 2002 at 05:18:04PM +0200, Steven Scholz wrote:
> >
> > Tom Rini wrote:
> >
> > > I'm sort-of supprised it works.
> > I told you, it's not that much to do...
> > :-)
> >
> > > Isn't:
> > > ((uint)0x....)
> > > in assembly bad?
> >
> > Hmm. Don't know. Maybe. But these are just DEFINES! So what should that
> > be bad?
>
> Oh yeah, right..  Hmm, it probably won't break anything then..
>
> > > I think we need to have all of these defines enclosed with the
> > > __ASSEMBLY__ test, but I can go fix that.
> >
> > At least spd8xx.h and tqm8xx.h don't have any #ifndef __ASSEMBLY__ at
> > all!?
>
> (... waking up ...) Because the only C bits they had are now in
> <asm/ppcboot.h> which does the test right.
>

All right then. I can't do more testing due to the lack of hardware.
Maybe Wolfgang could spend a little of his precious time since he claims
to have a zoo of boards... :o)
(Especially TQM8xxL, FPS850L, SM850)

So when can I "bk pull" these changes then, Tom?

Good luck,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
