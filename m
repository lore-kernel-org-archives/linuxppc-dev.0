Content-Type: text/plain;
  charset="iso-8859-1"
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Message-Id: <200112052124.4573@enzo.bigblue.local>
To: Tom Rini <trini@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Changes to PPC Linux required for GCC 3.1
Date: Wed, 5 Dec 2001 21:30:10 +0100
Cc: Corey Minyard <minyard@acm.org>,
	Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org, paulus@samba.org
References: <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net> <20011205175038.27184@smtp.adsl.oleane.com> <20011205194522.GA28241@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011205194522.GA28241@cpe-24-221-152-185.az.sprintbbd.net>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday 05 December 2001 20:45, Tom Rini wrote:
> On Wed, Dec 05, 2001 at 06:50:38PM +0100, Benjamin Herrenschmidt wrote:
> > >I think the reason this wasn't applied is that Paul said something about
> > >thiws being horriyingly ugly.  Corey, can you post a patch that changes
> > >RELOC(x) into a function and nothing else? :)
> >
> > I prefer this beeing resolved at compile time. The reason Paul didn't
> > want it at first is because he didn't want a workaround for a pre-release
> > gcc bug. Since this is becoming a "feature", it makes sense to get the
> > workaround. Paulus will confirm or not what I'm saying though...
>
> This was actually being hit by a 3.0.x release at the time I think (and
> we worked around it another way).  I'd prefer a clean function over an
> ugly macro any day :)

I don't understand how my patch makes the RELOC hack uglier than it is
already by itself ;-). The few affected files should really be reworked to be
compiled with something like -fPIC -mrelocateable (maybe with -msdata and
setup r12 accordingly).

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
