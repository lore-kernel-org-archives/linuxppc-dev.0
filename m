Message-ID: <3C0E0390.95CA5B75@wanadoo.fr>
Date: Wed, 05 Dec 2001 12:22:58 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
References: <3C0AA2AF.97E7FCB4@wanadoo.fr> <Pine.GSO.4.21.0112031415170.5519-100000@mullein.sonytel.be> <20011203080956.R7819@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
>
> On Mon, Dec 03, 2001 at 02:16:04PM +0100, Geert Uytterhoeven wrote:
> > On Sun, 2 Dec 2001, Martin Costabel wrote:
> > > Paul Mackerras wrote:
> > > > Martin Costabel writes:
[]
> > So please try `cmode 1' instead of `cmode 16'.
>
> These bits of code are always different still I think.  Valkyriefb for
> example parses 'cmode:{8,15,16}' and does CMODE_8 or CMODE_16.  I
> _think_ the userland tools did both 0/1/2 and 8/15/16/32 (24?).

I'll be happy to let my 6400 play the guinea pig, but I have to excuse
him until next week; I'm not at home right now.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
