Content-Type: text/plain;
  charset="iso-8859-1"
From: Lauri Ojantakanen <lauri.ojantakanen@solidtech.com>
To: "Mark A. Greer" <mgreer@mvista.com>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: Booting sandpoint from ide disk
Date: Sun, 8 Sep 2002 22:27:24 +0300
Cc: linuxppc-embedded@lists.linuxppc.org
References: <200209051316.19309.lauri.ojantakanen@solidtech.com> <20020906142827.GS761@opus.bloom.county> <3D78E533.97F0DA5F@mvista.com>
In-Reply-To: <3D78E533.97F0DA5F@mvista.com>
MIME-Version: 1.0
Message-Id: <200209082227.24217.lauri.ojantakanen@solidtech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Actually the worst thing is that I did not write anything to flash. I was just
considering to write zImage to flash. I just shutdown the linux running on
that board (booted with bootp) to get into dink and it just did not work
anymore.

//Lauri

On Friday 06 September 2002 20:26, Mark A. Greer wrote:
> Tom Rini wrote:
> > On Fri, Sep 06, 2002 at 11:02:58AM +0300, Lauri Ojantakanen wrote:
> > > Instant need for booting from ide disk seem to have gone away :( Dink32
> > > does not start anymore at all. When I restart the machine nothing comes
> > > through the serial cable (settings are correct). I have not touched to
> > > any board switches. Red leds on the altimus board are as follows:
> >
> > Were you trying to put the kernel in flash or something?  If you've got
> > access to HW debuggers (like the Abatron BDI) look at what's at
> > 0xFF00_0000, it should start off with a bunch of nop's.
>
> Ah, I guess I should have said, "Don't overwrite DINK" if that's what you
> did. If you overwrote DINK, you'll have to find a ROM burner & a copy of
> DINK and put it back on the FLASH.  After that, you can put the zImage
> either further back in that FLASH where id doesn't overwrite any other code
> or better yet put it in the secondary FLASH.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
