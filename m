Date: Tue, 4 Jun 2002 13:16:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>, Peter De Schrijver <p2@mind.be>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: S3 trio config
Message-ID: <20020604201607.GA1335@opus.bloom.county>
References: <Pine.GSO.4.21.0206011036580.13142-100000@vervain.sonytel.be> <1023014281.11116.14.camel@kettle.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1023014281.11116.14.camel@kettle.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 02, 2002 at 11:38:01AM +0100, Leigh Brown wrote:
> On Sat, 2002-06-01 at 09:39, Geert Uytterhoeven wrote:
> > On Sat, 1 Jun 2002, Paul Mackerras wrote:
> > > I wrote:
> > > > Does anyone know why we have this?  Is the S3 Trio display really only
> > > > used on PReP or CHRP machines, not on any PCs?
> > >
> > > I should have said, not on any other PPC systems, of course, since
> > > that code was in a CONFIG_PPC section.
> >
> > S3triofb relies on Open Firmware, so it can work on PowerMac/CHRP only. AFAIK
> > it was used on CHRP only.
>
> Well, S3triofb hasn't even compiled for ages.  I've attached a patch
> that allows it to compile, and removes the dependency on OF.  However,
> it still requires some sort of firmware to initialise the card.  I've
> added a little hack so that it ignores the card if it wasn't initialised
> by the firmware, since the driver doesn't have the code to initialise it
> properly.

Okay, I've applied this patch and done a bit more work so that it
_might_ work as a module.  Geert, who should all of this goto in the end
since it doesn't seem like this driver has had an active maintainer for
a while..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
