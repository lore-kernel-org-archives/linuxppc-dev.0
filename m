Message-ID: <3D10A0AC.409EF92B@imc-berlin.de>
Date: Wed, 19 Jun 2002 17:18:04 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <3D106922.7026437A@imc-berlin.de> <20020619150520.GA12762@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> I'm sort-of supprised it works.
I told you, it's not that much to do...
:-)

> Isn't:
> ((uint)0x....)
> in assembly bad?

Hmm. Don't know. Maybe. But these are just DEFINES! So what should that
be bad?

> I think we need to have all of these defines enclosed with the
> __ASSEMBLY__ test, but I can go fix that.

At least spd8xx.h and tqm8xx.h don't have any #ifndef __ASSEMBLY__ at
all!?

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
