Date: Wed, 19 Jun 2002 08:25:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
Message-ID: <20020619152528.GB12762@opus.bloom.county>
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <3D106922.7026437A@imc-berlin.de> <20020619150520.GA12762@opus.bloom.county> <3D10A0AC.409EF92B@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D10A0AC.409EF92B@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 19, 2002 at 05:18:04PM +0200, Steven Scholz wrote:
>
> Tom Rini wrote:
>
> > I'm sort-of supprised it works.
> I told you, it's not that much to do...
> :-)
>
> > Isn't:
> > ((uint)0x....)
> > in assembly bad?
>
> Hmm. Don't know. Maybe. But these are just DEFINES! So what should that
> be bad?

Oh yeah, right..  Hmm, it probably won't break anything then..

> > I think we need to have all of these defines enclosed with the
> > __ASSEMBLY__ test, but I can go fix that.
>
> At least spd8xx.h and tqm8xx.h don't have any #ifndef __ASSEMBLY__ at
> all!?

(... waking up ...) Because the only C bits they had are now in
<asm/ppcboot.h> which does the test right.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
