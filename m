Message-ID: <3D78E533.97F0DA5F@mvista.com>
Date: Fri, 06 Sep 2002 13:26:11 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Lauri Ojantakanen <lauri.ojantakanen@solidtech.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting sandpoint from ide disk
References: <200209051316.19309.lauri.ojantakanen@solidtech.com> <3D777C99.97AF4D14@mvista.com> <200209061102.58480.lauri.ojantakanen@solidtech.com> <20020906142827.GS761@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> On Fri, Sep 06, 2002 at 11:02:58AM +0300, Lauri Ojantakanen wrote:
>
> > Instant need for booting from ide disk seem to have gone away :( Dink32 does
> > not start anymore at all. When I restart the machine nothing comes through
> > the serial cable (settings are correct). I have not touched to any board
> > switches. Red leds on the altimus board are as follows:
>
> Were you trying to put the kernel in flash or something?  If you've got
> access to HW debuggers (like the Abatron BDI) look at what's at
> 0xFF00_0000, it should start off with a bunch of nop's.

Ah, I guess I should have said, "Don't overwrite DINK" if that's what you did.
If you overwrote DINK, you'll have to find a ROM burner & a copy of DINK and put
it back on the FLASH.  After that, you can put the zImage either further back in
that FLASH where id doesn't overwrite any other code or better yet put it in the
secondary FLASH.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
