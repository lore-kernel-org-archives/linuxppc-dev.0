Date: Wed, 5 Dec 2001 20:38:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Corey Minyard <minyard@acm.org>
Cc: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to PPC Linux required for GCC 3.1
Message-ID: <20011206033823.GE17651@cpe-24-221-152-185.az.sprintbbd.net>
References: <5.1.0.14.2.20011205134825.024d8ed8@mail.lauterbach.com> <3C0E48D2.6000409@acm.org> <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net> <3C0EC2E2.4020208@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C0EC2E2.4020208@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 05, 2001 at 06:59:14PM -0600, Corey Minyard wrote:
>
> Tom Rini wrote:
>
> >
> >I think the reason this wasn't applied is that Paul said something about
> >thiws being horriyingly ugly.  Corey, can you post a patch that changes
> >RELOC(x) into a function and nothing else? :)
>
> My original patch has the function.

Your patch had other fixes too tho.

> I prefer the macro, it may be a
> little uglier but it removes a dependency between the include file and
> the source.

Er, say what?  The macro is in the include file now...

> It needs to be commented though, the reason for it's
> wierdness is not really clear.

Well, that is somewhat true.  But the early boot stuffs are somewhat
mysterious from time to time anyways :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
