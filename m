Date: Fri, 6 Sep 2002 07:28:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Lauri Ojantakanen <lauri.ojantakanen@solidtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting sandpoint from ide disk
Message-ID: <20020906142827.GS761@opus.bloom.county>
References: <200209051316.19309.lauri.ojantakanen@solidtech.com> <3D777C99.97AF4D14@mvista.com> <200209061102.58480.lauri.ojantakanen@solidtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209061102.58480.lauri.ojantakanen@solidtech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 06, 2002 at 11:02:58AM +0300, Lauri Ojantakanen wrote:

> Instant need for booting from ide disk seem to have gone away :( Dink32 does
> not start anymore at all. When I restart the machine nothing comes through
> the serial cable (settings are correct). I have not touched to any board
> switches. Red leds on the altimus board are as follows:

Were you trying to put the kernel in flash or something?  If you've got
access to HW debuggers (like the Abatron BDI) look at what's at
0xFF00_0000, it should start off with a bunch of nop's.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
