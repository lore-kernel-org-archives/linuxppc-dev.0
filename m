Message-ID: <3B78294F.63D4945@iiic.ethz.ch>
Date: Mon, 13 Aug 2001 21:23:59 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Michel Lanners <mlan@cpu.lu>, bob@kunk.jriver.com,
	debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Compiling EIDE patch on PPC
References: <20010810161714.E28914@mikef-linux.matchmail.com> <200108110647.IAA00781@piglet.grunz.lu> <20010813101939.A21730@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike Fedyk wrote:

> > > Also, there is an include for asm/ide.h in apus_setup.c.  I didn't
> > > change it because I don't have any prep machines for testing, and for
> > > some reason it is also including from the m86k arch.
> >
> > APUS is not PREP, its some Amiga stuff. Basically, originally 68k-Amigas
> > upgraded with PPC processors; so no wonder they're a hybrid of m68k and
> > ppc ;-). I would _guess_ they need the <asm/ide.h> replaced by
> > <linux/ide.h> too.
>
> Oops, brain fart.  Did any of those APUS have PCI?

Yes and no. Not for IDE so far.

> If not, then the change may not be needed.

I don't know offhand, but don't worry, we'll take care of it.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
